import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/localized_text.dart';
import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

/// A single quiz item from official content or user-created decks.
class Card {
  const Card({
    required this.id,
    required this.categoryType,
    required this.lessonId,
    required this.answer,
    required this.sortOrder,
    required this.sync,
    this.notation,
    this.hint,
  });

  final String id;
  final CardCategoryType categoryType;
  final String lessonId;
  final NotationPayload? notation;
  final LocalizedText answer;
  final LocalizedText? hint;
  final int sortOrder;
  final SyncMetadata sync;

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] as String,
      categoryType: CardCategoryType.values.byName(json['categoryType'] as String),
      lessonId: json['lessonId'] as String,
      notation: json['notation'] == null
          ? null
          : NotationPayload.fromJson(json['notation'] as Map<String, dynamic>),
      answer: LocalizedText.fromJson(json['answer'] as Map<String, dynamic>),
      hint: json['hint'] == null
          ? null
          : LocalizedText.fromJson(json['hint'] as Map<String, dynamic>),
      sortOrder: json['sortOrder'] as int,
      sync: SyncMetadata(
        version: json['version'] as int? ?? 1,
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        lastSyncedAt: json['lastSyncedAt'] == null
            ? null
            : DateTime.parse(json['lastSyncedAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryType': categoryType.name,
      'lessonId': lessonId,
      if (notation != null) 'notation': notation!.toJson(),
      'answer': answer.toJson(),
      if (hint != null) 'hint': hint!.toJson(),
      'sortOrder': sortOrder,
      'version': sync.version,
      'updatedAt': sync.updatedAt.toIso8601String(),
      if (sync.lastSyncedAt != null)
        'lastSyncedAt': sync.lastSyncedAt!.toIso8601String(),
    };
  }
}