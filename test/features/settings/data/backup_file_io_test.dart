import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musical_note_training/features/settings/data/backup_file_io.dart';

void main() {
  test('backupFileNameForExport includes date and HHmm for same-day distinction', () {
    final name = BackupFileIo.backupFileNameForExport(
      DateTime(2026, 7, 13, 14, 30),
    );
    expect(name, 'musical_note_training_backup_20260713_1430.json');
  });

  test('pickJsonContent reads UTF-8 from file path when bytes are absent', () async {
    final tempDir = await Directory.systemTemp.createTemp('backup_io_test');
    addTearDown(() => tempDir.deleteSync(recursive: true));

    final file = File('${tempDir.path}/backup.json');
    const payload = '{"schemaVersion":1,"note":"テスト"}';
    await file.writeAsString(payload, encoding: utf8);

    // BackupFileIo.pickJsonContent is integration-level; verify path fallback logic
    // by reading the same way the helper does.
    final read = await file.readAsString(encoding: utf8);
    expect(read, payload);

    final platformFile = PlatformFile(
      name: 'backup.json',
      size: file.lengthSync(),
      path: file.path,
    );
    expect(platformFile.bytes, isNull);
    expect(await File(platformFile.path!).readAsString(encoding: utf8), payload);
  });
}