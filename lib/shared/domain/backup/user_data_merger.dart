import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';
import 'package:musical_note_training/shared/domain/models/study_progress.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

/// Merges two [UserDataSnapshot] values for multi-device sync.
abstract final class UserDataMerger {
  static UserDataSnapshot merge({
    required UserDataSnapshot local,
    required UserDataSnapshot remote,
  }) {
    final deckById = <String, Deck>{};
    for (final deck in local.decks) {
      deckById[deck.id] = deck;
    }
    for (final deck in remote.decks) {
      final existing = deckById[deck.id];
      if (existing == null || deck.sync.version > existing.sync.version) {
        deckById[deck.id] = deck;
      }
    }

    final deckCardKey = (DeckCard c) => '${c.deckId}\0${c.cardId}';
    final cardByKey = <String, DeckCard>{};
    for (final card in local.deckCards) {
      cardByKey[deckCardKey(card)] = card;
    }
    for (final card in remote.deckCards) {
      final key = deckCardKey(card);
      final existing = cardByKey[key];
      if (existing == null || card.addedAt.isAfter(existing.addedAt)) {
        cardByKey[key] = card;
      }
    }

    final weakByCardId = <String, WeakItem>{};
    for (final item in local.weakItems) {
      weakByCardId[item.cardId] = item;
    }
    for (final item in remote.weakItems) {
      final existing = weakByCardId[item.cardId];
      if (existing == null || item.sync.version > existing.sync.version) {
        weakByCardId[item.cardId] = item;
      }
    }

    final progressByLesson = <String, StudyProgress>{};
    for (final entry in local.studyProgress) {
      progressByLesson[entry.lessonId] = entry;
    }
    for (final entry in remote.studyProgress) {
      final existing = progressByLesson[entry.lessonId];
      if (existing == null || entry.sync.version > existing.sync.version) {
        progressByLesson[entry.lessonId] = entry;
      } else if (entry.sync.version == existing.sync.version) {
        progressByLesson[entry.lessonId] = StudyProgress(
          id: existing.id,
          lessonId: existing.lessonId,
          completedCardIds: {
            ...existing.completedCardIds,
            ...entry.completedCardIds,
          },
          sync: existing.sync,
        );
      }
    }

    final settings = remote.exportedAt.isAfter(local.exportedAt)
        ? remote.settings
        : local.settings;

    final exportedAt = local.exportedAt.isAfter(remote.exportedAt)
        ? local.exportedAt
        : remote.exportedAt;

    return UserDataSnapshot(
      schemaVersion: UserDataSnapshot.currentSchemaVersion,
      exportedAt: exportedAt,
      settings: settings,
      decks: deckById.values.toList()
        ..sort((a, b) => b.sync.updatedAt.compareTo(a.sync.updatedAt)),
      deckCards: cardByKey.values.toList()
        ..sort((a, b) {
          final byDeck = a.deckId.compareTo(b.deckId);
          if (byDeck != 0) return byDeck;
          return a.sortOrder.compareTo(b.sortOrder);
        }),
      weakItems: weakByCardId.values.toList()
        ..sort((a, b) => b.sync.updatedAt.compareTo(a.sync.updatedAt)),
      studyProgress: progressByLesson.values.toList()
        ..sort((a, b) => a.lessonId.compareTo(b.lessonId)),
    );
  }
}