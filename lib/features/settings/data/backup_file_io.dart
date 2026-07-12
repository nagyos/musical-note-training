import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Platform-specific backup file export and import (no Google Drive).
abstract final class BackupFileIo {
  static const _jsonTypeGroup = XTypeGroup(
    label: 'JSON',
    extensions: ['json'],
  );

  /// True when export writes via a save dialog instead of the share sheet.
  static bool get exportUsesSaveDialog => !_shareFilesSupported;

  static bool get _shareFilesSupported {
    if (kIsWeb) return false;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => true,
      _ => false,
    };
  }

  static bool get _useFileSelector {
    if (kIsWeb) return false;
    return !_shareFilesSupported;
  }

  /// Default export filename, e.g. `musical_note_training_backup_20260713_1430.json`.
  static String backupFileNameForExport([DateTime? at]) {
    final now = at ?? DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final h = now.hour.toString().padLeft(2, '0');
    final min = now.minute.toString().padLeft(2, '0');
    return 'musical_note_training_backup_${y}${m}${d}_$h$min.json';
  }

  /// Writes [json] and returns the saved path. On mobile also opens the share sheet.
  static Future<String?> exportJson(String json, {String? shareSubject}) async {
    final fileName = backupFileNameForExport();

    if (_shareFilesSupported) {
      final dir = await getTemporaryDirectory();
      final file = File(p.join(dir.path, fileName));
      await file.writeAsString(json);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: shareSubject,
        ),
      );
      return file.path;
    }

    if (_useFileSelector) {
      final saveLocation = await getSaveLocation(
        suggestedName: fileName,
        acceptedTypeGroups: const [_jsonTypeGroup],
      );
      if (saveLocation == null) return null;
      final savePath = saveLocation.path;
      await File(savePath).writeAsString(json);
      return savePath;
    }

    final downloads = await getDownloadsDirectory();
    final dir = downloads ?? await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, fileName));
    await file.writeAsString(json);
    return file.path;
  }

  /// Reads JSON from a user-picked file, or null if the picker was cancelled.
  static Future<String?> pickJsonContent() async {
    if (_useFileSelector) {
      final file = await openFile(acceptedTypeGroups: const [_jsonTypeGroup]);
      if (file == null) return null;
      return file.readAsString();
    }

    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
      withData: true,
    );
    final files = picked?.files;
    if (files == null || files.isEmpty) return null;

    final platformFile = files.first;
    final inline = platformFile.bytes;
    if (inline != null && inline.isNotEmpty) {
      return utf8.decode(inline);
    }

    final path = platformFile.path;
    if (path == null) {
      throw StateError('Selected file has no readable path or bytes');
    }
    return File(path).readAsString();
  }
}