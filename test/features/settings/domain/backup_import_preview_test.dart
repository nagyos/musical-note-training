import 'package:flutter_test/flutter_test.dart';
import 'package:musical_note_training/features/settings/domain/backup_import_preview.dart';
import 'package:musical_note_training/shared/domain/backup/settings_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/models/study_progress.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

void main() {
  final exportedAt = DateTime.utc(2026, 7, 13, 12);

  UserDataSnapshot snapshot({
    int decks = 0,
    int weak = 0,
    int progress = 0,
    SettingsSnapshot settings = SettingsSnapshot.defaults,
  }) {
    return UserDataSnapshot(
      schemaVersion: 1,
      exportedAt: exportedAt,
      settings: settings,
      decks: List.generate(
        decks,
        (i) => Deck(
          id: 'd$i',
          name: 'Deck $i',
          createdAt: exportedAt,
          sync: SyncMetadata(version: 1, updatedAt: exportedAt),
        ),
      ),
      deckCards: const [],
      weakItems: List.generate(
        weak,
        (i) => WeakItem(
          id: 'w$i',
          cardId: 'c$i',
          wrongCount: 1,
          correctCount: 0,
          sync: SyncMetadata(version: 1, updatedAt: exportedAt),
        ),
      ),
      studyProgress: List.generate(
        progress,
        (i) => StudyProgress(
          id: 'p$i',
          lessonId: 'lesson-$i',
          completedCardIds: const {},
          sync: SyncMetadata(version: 1, updatedAt: exportedAt),
        ),
      ),
    );
  }

  test('computes positive and negative count deltas', () {
    final preview = BackupImportPreview(
      local: snapshot(decks: 1, weak: 5),
      remote: snapshot(decks: 3, weak: 2, progress: 1),
    );

    expect(preview.deckDelta, 2);
    expect(preview.weakDelta, -3);
    expect(preview.progressDelta, 1);
    expect(preview.settingsChange, isFalse);
  });

  test('detects settings changes', () {
    final preview = BackupImportPreview(
      local: snapshot(),
      remote: snapshot(
        settings: const SettingsSnapshot(
          uiLocaleCode: 'en',
          noteNameStyle: 'letter',
        ),
      ),
    );

    expect(preview.uiLocaleChanges, isTrue);
    expect(preview.noteNameStyleChanges, isTrue);
    expect(preview.settingsChange, isTrue);
  });
}