import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/features/settings/data/settings_repository.dart';
import 'package:musical_note_training/features/settings/domain/app_settings.dart';
import 'package:musical_note_training/features/settings/domain/note_name_style.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SharedPreferencesSettingsRepository(),
);

final appSettingsProvider =
    NotifierProvider<AppSettingsNotifier, AppSettings>(AppSettingsNotifier.new);

/// Locale key for card answer choices (solfege vs letter names).
final answerLocaleProvider = Provider<String>(
  (ref) => ref.watch(appSettingsProvider).answerLocaleKey,
);

class AppSettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    _loadFromStorage();
    return AppSettings.defaults;
  }

  Future<void> _loadFromStorage() async {
    final loaded = await ref.read(settingsRepositoryProvider).load();
    state = loaded;
  }

  Future<void> setUiLocaleCode(String code) async {
    final next = state.copyWith(uiLocaleCode: code);
    state = next;
    await ref.read(settingsRepositoryProvider).save(next);
  }

  Future<void> setNoteNameStyle(NoteNameStyle style) async {
    final next = state.copyWith(noteNameStyle: style);
    state = next;
    await ref.read(settingsRepositoryProvider).save(next);
  }

  Future<void> reloadFromStorage() async {
    final loaded = await ref.read(settingsRepositoryProvider).load();
    state = loaded;
  }
}