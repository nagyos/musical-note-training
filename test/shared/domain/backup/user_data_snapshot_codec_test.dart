import 'package:flutter_test/flutter_test.dart';
import 'package:musical_note_training/shared/domain/backup/settings_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot_codec.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_merger.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

void main() {
  final exportedAt = DateTime.utc(2026, 7, 12, 12);

  UserDataSnapshot emptySnapshot() => UserDataSnapshot(
        schemaVersion: UserDataSnapshot.currentSchemaVersion,
        exportedAt: exportedAt,
        settings: SettingsSnapshot.defaults,
        decks: const [],
        deckCards: const [],
        weakItems: const [],
        studyProgress: const [],
      );

  group('UserDataSnapshotCodec', () {
    test('round-trips snapshot through JSON', () {
      final original = UserDataSnapshot(
        schemaVersion: 1,
        exportedAt: exportedAt,
        settings: const SettingsSnapshot(
          uiLocaleCode: 'en',
          noteNameStyle: 'letter',
        ),
        decks: [
          Deck(
            id: 'deck-1',
            name: 'My deck',
            createdAt: exportedAt,
            sync: SyncMetadata(version: 2, updatedAt: exportedAt),
          ),
        ],
        deckCards: const [],
        weakItems: [
          WeakItem(
            id: 'weak-1',
            cardId: 'note-c4',
            wrongCount: 1,
            correctCount: 0,
            sync: SyncMetadata(version: 1, updatedAt: exportedAt),
          ),
        ],
        studyProgress: const [],
      );

      final restored = UserDataSnapshotCodec.decode(
        UserDataSnapshotCodec.encode(original),
      );

      expect(restored.settings.uiLocaleCode, 'en');
      expect(restored.decks.single.name, 'My deck');
      expect(restored.weakItems.single.cardId, 'note-c4');
    });

    test('rejects unknown schema version', () {
      expect(
        () => UserDataSnapshotCodec.fromJson({
          'schemaVersion': 99,
          'exportedAt': exportedAt.toIso8601String(),
          'settings': {'uiLocaleCode': 'ja', 'noteNameStyle': 'solfege'},
          'decks': [],
          'deckCards': [],
          'weakItems': [],
          'studyProgress': [],
        }),
        throwsFormatException,
      );
    });
  });

  group('UserDataMerger', () {
    test('keeps deck with higher sync version', () {
      final local = emptySnapshot().copyWithDecks([
        Deck(
          id: 'd1',
          name: 'Local',
          createdAt: exportedAt,
          sync: SyncMetadata(version: 1, updatedAt: exportedAt),
        ),
      ]);
      final remote = emptySnapshot().copyWithDecks([
        Deck(
          id: 'd1',
          name: 'Remote',
          createdAt: exportedAt,
          sync: SyncMetadata(
            version: 3,
            updatedAt: exportedAt.add(const Duration(hours: 1)),
          ),
        ),
      ]);

      final merged = UserDataMerger.merge(local: local, remote: remote);
      expect(merged.decks.single.name, 'Remote');
    });
  });
}

extension on UserDataSnapshot {
  UserDataSnapshot copyWithDecks(List<Deck> decks) {
    return UserDataSnapshot(
      schemaVersion: schemaVersion,
      exportedAt: exportedAt,
      settings: settings,
      decks: decks,
      deckCards: deckCards,
      weakItems: weakItems,
      studyProgress: studyProgress,
    );
  }
}