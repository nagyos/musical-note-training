import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart'
    as db;
import 'package:musical_note_training/shared/data/mappers/deck_mapper.dart';
import 'package:musical_note_training/shared/data/mappers/weak_item_mapper.dart';
import 'package:musical_note_training/shared/domain/backup/settings_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/models/study_progress.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

/// Reads and writes [UserDataSnapshot] against the local drift database.
class DriftUserDataBackupStore {
  DriftUserDataBackupStore(this._database);

  final db.AppDatabase _database;

  Future<UserDataSnapshot> exportSnapshot({
    required SettingsSnapshot settings,
    DateTime? exportedAt,
  }) async {
    final now = (exportedAt ?? DateTime.now()).toUtc();

    final deckRows = await _database.select(_database.decks).get();
    final cardRows = await _database.select(_database.deckCards).get();
    final weakRows = await _database.select(_database.weakItems).get();
    final progressRows =
        await _database.select(_database.studyProgressEntries).get();

    return UserDataSnapshot(
      schemaVersion: UserDataSnapshot.currentSchemaVersion,
      exportedAt: now,
      settings: settings,
      decks: deckRows.map(DeckMapper.toDomain).toList(),
      deckCards: cardRows.map(DeckMapper.toDeckCardDomain).toList(),
      weakItems: weakRows.map(WeakItemMapper.toDomain).toList(),
      studyProgress: progressRows.map(_progressFromRow).toList(),
    );
  }

  Future<void> applySnapshot(UserDataSnapshot snapshot) async {
    await _database.transaction(() async {
      await _database.delete(_database.deckCards).go();
      await _database.delete(_database.decks).go();
      await _database.delete(_database.weakItems).go();
      await _database.delete(_database.studyProgressEntries).go();

      for (final deck in snapshot.decks) {
        await _database.into(_database.decks).insert(
              db.DecksCompanion.insert(
                id: deck.id,
                name: deck.name,
                description: Value(deck.description),
                createdAt: deck.createdAt,
                version: Value(deck.sync.version),
                updatedAt: deck.sync.updatedAt,
                lastSyncedAt: Value(deck.sync.lastSyncedAt),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }

      for (final card in snapshot.deckCards) {
        await _database.into(_database.deckCards).insert(
              db.DeckCardsCompanion.insert(
                deckId: card.deckId,
                cardId: card.cardId,
                sortOrder: card.sortOrder,
                addedAt: card.addedAt,
              ),
              mode: InsertMode.insertOrReplace,
            );
      }

      for (final item in snapshot.weakItems) {
        await _database.into(_database.weakItems).insert(
              db.WeakItemsCompanion.insert(
                id: item.id,
                cardId: item.cardId,
                wrongCount: Value(item.wrongCount),
                correctCount: Value(item.correctCount),
                lastAnsweredAt: Value(item.lastAnsweredAt),
                version: Value(item.sync.version),
                updatedAt: item.sync.updatedAt,
                lastSyncedAt: Value(item.sync.lastSyncedAt),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }

      for (final progress in snapshot.studyProgress) {
        await _database.into(_database.studyProgressEntries).insert(
              db.StudyProgressEntriesCompanion.insert(
                id: progress.id,
                lessonId: progress.lessonId,
                completedCardIds: jsonEncode(
                  progress.completedCardIds.toList()..sort(),
                ),
                version: Value(progress.sync.version),
                updatedAt: progress.sync.updatedAt,
                lastSyncedAt: Value(progress.sync.lastSyncedAt),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
  }

  StudyProgress _progressFromRow(db.StudyProgressEntry row) {
    final ids = (jsonDecode(row.completedCardIds) as List<dynamic>)
        .map((e) => e as String)
        .toSet();
    return StudyProgress(
      id: row.id,
      lessonId: row.lessonId,
      completedCardIds: ids,
      sync: SyncMetadata(
        version: row.version,
        updatedAt: row.updatedAt,
        lastSyncedAt: row.lastSyncedAt,
      ),
    );
  }
}