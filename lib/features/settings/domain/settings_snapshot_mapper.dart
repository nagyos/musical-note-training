import 'package:musical_note_training/features/settings/domain/app_settings.dart';
import 'package:musical_note_training/features/settings/domain/note_name_style.dart';
import 'package:musical_note_training/shared/domain/backup/settings_snapshot.dart';

abstract final class SettingsSnapshotMapper {
  static SettingsSnapshot fromAppSettings(AppSettings settings) {
    return SettingsSnapshot(
      uiLocaleCode: settings.uiLocaleCode,
      noteNameStyle: settings.noteNameStyle.storageValue,
    );
  }

  static AppSettings toAppSettings(SettingsSnapshot snapshot) {
    return AppSettings(
      uiLocaleCode: snapshot.uiLocaleCode,
      noteNameStyle: NoteNameStyle.fromStorage(snapshot.noteNameStyle),
    );
  }
}