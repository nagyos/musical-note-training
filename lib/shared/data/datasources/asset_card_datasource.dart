import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:musical_note_training/core/constants/content_assets.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/category.dart';
import 'package:musical_note_training/shared/domain/models/lesson.dart';

/// Loads official card content from Flutter asset bundles.
class AssetCardDatasource {
  const AssetCardDatasource();

  Future<List<Category>> loadCategories() async {
    final json = await rootBundle.loadString(ContentAssets.categories);
    final list = jsonDecode(json) as List<dynamic>;
    return list
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  Future<CategoryContentBundle> loadCategoryBundle(String categoryId) async {
    final path = ContentAssets.bundleForCategory(categoryId);
    final json = await rootBundle.loadString(path);
    final map = jsonDecode(json) as Map<String, dynamic>;

    final lessons = (map['lessons'] as List<dynamic>)
        .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    final cards = (map['cards'] as List<dynamic>)
        .map((e) => Card.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return CategoryContentBundle(lessons: lessons, cards: cards);
  }
}

class CategoryContentBundle {
  const CategoryContentBundle({required this.lessons, required this.cards});

  final List<Lesson> lessons;
  final List<Card> cards;
}