import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';

/// Compares local data with a backup file before overwrite import.
class BackupImportPreview {
  const BackupImportPreview({
    required this.local,
    required this.remote,
  });

  final UserDataSnapshot local;
  final UserDataSnapshot remote;

  int get localDeckCount => local.decks.length;
  int get remoteDeckCount => remote.decks.length;
  int get deckDelta => remoteDeckCount - localDeckCount;

  int get localWeakCount => local.weakItems.length;
  int get remoteWeakCount => remote.weakItems.length;
  int get weakDelta => remoteWeakCount - localWeakCount;

  int get localProgressCount => local.studyProgress.length;
  int get remoteProgressCount => remote.studyProgress.length;
  int get progressDelta => remoteProgressCount - localProgressCount;

  bool get uiLocaleChanges =>
      local.settings.uiLocaleCode != remote.settings.uiLocaleCode;

  bool get noteNameStyleChanges =>
      local.settings.noteNameStyle != remote.settings.noteNameStyle;

  bool get settingsChange => uiLocaleChanges || noteNameStyleChanges;
}