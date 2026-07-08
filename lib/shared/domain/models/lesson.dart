import 'package:musical_note_training/shared/domain/models/localized_text.dart';

/// A sub-unit within a [Category] (e.g. 中央ド周辺).
class Lesson {
  const Lesson({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.sortOrder,
  });

  final String id;
  final String categoryId;
  final LocalizedText title;
  final int sortOrder;

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
      sortOrder: json['sortOrder'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title.toJson(),
      'sortOrder': sortOrder,
    };
  }
}