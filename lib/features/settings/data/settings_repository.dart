import 'package:musical_note_training/features/settings/domain/app_settings.dart';
import 'package:musical_note_training/features/settings/domain/note_name_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<AppSettings> load();

  Future<void> save(AppSettings settings);
}

class SharedPreferencesSettingsRepository implements SettingsRepository {
  static const uiLocaleKey = 'ui_locale';
  static const noteNameStyleKey = 'note_name_style';

  @override
  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString(uiLocaleKey);
    final noteStyle = prefs.getString(noteNameStyleKey);

    if (locale == null && noteStyle == null) {
      return AppSettings.defaults;
    }

    return AppSettings(
      uiLocaleCode: locale ?? AppSettings.defaults.uiLocaleCode,
      noteNameStyle: NoteNameStyle.fromStorage(noteStyle),
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(uiLocaleKey, settings.uiLocaleCode);
    await prefs.setString(noteNameStyleKey, settings.noteNameStyle.storageValue);
  }
}