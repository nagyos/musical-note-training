import 'dart:convert';

import 'package:musical_note_training/shared/domain/backup/settings_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';
import 'package:musical_note_training/shared/domain/models/study_progress.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

abstract final class UserDataSnapshotCodec {
  static String encode(UserDataSnapshot snapshot) {
    return const JsonEncoder.withIndent('  ').convert(toJson(snapshot));
  }

  static UserDataSnapshot decode(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return fromJson(map);
  }

  static Map<String, dynamic> toJson(UserDataSnapshot snapshot) {
    return {
      'schemaVersion': snapshot.schemaVersion,
      'exportedAt': snapshot.exportedAt.toUtc().toIso8601String(),
      'settings': _settingsToJson(snapshot.settings),
      'decks': snapshot.decks.map(_deckToJson).toList(),
      'deckCards': snapshot.deckCards.map(_deckCardToJson).toList(),
      'weakItems': snapshot.weakItems.map(_weakItemToJson).toList(),
      'studyProgress': snapshot.studyProgress.map(_progressToJson).toList(),
    };
  }

  static UserDataSnapshot fromJson(Map<String, dynamic> json) {
    final schemaVersion = json['schemaVersion'] as int? ?? 0;
    if (schemaVersion != UserDataSnapshot.currentSchemaVersion) {
      throw FormatException('Unsupported backup schema version: $schemaVersion');
    }

    return UserDataSnapshot(
      schemaVersion: schemaVersion,
      exportedAt: DateTime.parse(json['exportedAt'] as String).toUtc(),
      settings: _settingsFromJson(json['settings'] as Map<String, dynamic>),
      decks: (json['decks'] as List<dynamic>)
          .map((e) => _deckFromJson(e as Map<String, dynamic>))
          .toList(),
      deckCards: (json['deckCards'] as List<dynamic>)
          .map((e) => _deckCardFromJson(e as Map<String, dynamic>))
          .toList(),
      weakItems: (json['weakItems'] as List<dynamic>)
          .map((e) => _weakItemFromJson(e as Map<String, dynamic>))
          .toList(),
      studyProgress: (json['studyProgress'] as List<dynamic>)
          .map((e) => _progressFromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static Map<String, dynamic> _settingsToJson(SettingsSnapshot settings) {
    return {
      'uiLocaleCode': settings.uiLocaleCode,
      'noteNameStyle': settings.noteNameStyle,
    };
  }

  static SettingsSnapshot _settingsFromJson(Map<String, dynamic> json) {
    return SettingsSnapshot(
      uiLocaleCode: json['uiLocaleCode'] as String? ?? 'ja',
      noteNameStyle: json['noteNameStyle'] as String? ?? 'solfege',
    );
  }

  static Map<String, dynamic> _syncToJson(SyncMetadata sync) {
    return {
      'version': sync.version,
      'updatedAt': sync.updatedAt.toUtc().toIso8601String(),
      if (sync.lastSyncedAt != null)
        'lastSyncedAt': sync.lastSyncedAt!.toUtc().toIso8601String(),
    };
  }

  static SyncMetadata _syncFromJson(Map<String, dynamic> json) {
    return SyncMetadata(
      version: json['version'] as int? ?? 1,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String).toUtc(),
    );
  }

  static Map<String, dynamic> _deckToJson(Deck deck) {
    return {
      'id': deck.id,
      'name': deck.name,
      if (deck.description != null) 'description': deck.description,
      'createdAt': deck.createdAt.toUtc().toIso8601String(),
      'sync': _syncToJson(deck.sync),
    };
  }

  static Deck _deckFromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
      sync: _syncFromJson(json['sync'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> _deckCardToJson(DeckCard card) {
    return {
      'deckId': card.deckId,
      'cardId': card.cardId,
      'sortOrder': card.sortOrder,
      'addedAt': card.addedAt.toUtc().toIso8601String(),
    };
  }

  static DeckCard _deckCardFromJson(Map<String, dynamic> json) {
    return DeckCard(
      deckId: json['deckId'] as String,
      cardId: json['cardId'] as String,
      sortOrder: json['sortOrder'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String).toUtc(),
    );
  }

  static Map<String, dynamic> _weakItemToJson(WeakItem item) {
    return {
      'id': item.id,
      'cardId': item.cardId,
      'wrongCount': item.wrongCount,
      'correctCount': item.correctCount,
      if (item.lastAnsweredAt != null)
        'lastAnsweredAt': item.lastAnsweredAt!.toUtc().toIso8601String(),
      'sync': _syncToJson(item.sync),
    };
  }

  static WeakItem _weakItemFromJson(Map<String, dynamic> json) {
    return WeakItem(
      id: json['id'] as String,
      cardId: json['cardId'] as String,
      wrongCount: json['wrongCount'] as int? ?? 0,
      correctCount: json['correctCount'] as int? ?? 0,
      lastAnsweredAt: json['lastAnsweredAt'] == null
          ? null
          : DateTime.parse(json['lastAnsweredAt'] as String).toUtc(),
      sync: _syncFromJson(json['sync'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> _progressToJson(StudyProgress progress) {
    return {
      'id': progress.id,
      'lessonId': progress.lessonId,
      'completedCardIds': progress.completedCardIds.toList()..sort(),
      'sync': _syncToJson(progress.sync),
    };
  }

  static StudyProgress _progressFromJson(Map<String, dynamic> json) {
    return StudyProgress(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      completedCardIds: (json['completedCardIds'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
      sync: _syncFromJson(json['sync'] as Map<String, dynamic>),
    );
  }
}