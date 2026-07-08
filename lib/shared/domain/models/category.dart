import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/localized_text.dart';

/// Top-level learning category (音符 / 休符 / 記号 …).
class Category {
  const Category({
    required this.id,
    required this.type,
    required this.title,
    required this.sortOrder,
  });

  final String id;
  final CardCategoryType type;
  final LocalizedText title;
  final int sortOrder;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      type: CardCategoryType.values.byName(json['type'] as String),
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
      sortOrder: json['sortOrder'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title.toJson(),
      'sortOrder': sortOrder,
    };
  }
}