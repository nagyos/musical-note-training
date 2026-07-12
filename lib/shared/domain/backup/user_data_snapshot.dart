import 'package:musical_note_training/shared/domain/backup/settings_snapshot.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';
import 'package:musical_note_training/shared/domain/models/study_progress.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

/// Portable backup of all user-owned app data (not official catalog cards).
class UserDataSnapshot {
  const UserDataSnapshot({
    required this.schemaVersion,
    required this.exportedAt,
    required this.settings,
    required this.decks,
    required this.deckCards,
    required this.weakItems,
    required this.studyProgress,
  });

  static const int currentSchemaVersion = 1;

  final int schemaVersion;
  final DateTime exportedAt;
  final SettingsSnapshot settings;
  final List<Deck> decks;
  final List<DeckCard> deckCards;
  final List<WeakItem> weakItems;
  final List<StudyProgress> studyProgress;
}