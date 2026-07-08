import 'package:musical_note_training/core/constants/content_assets.dart';
import 'package:musical_note_training/shared/data/datasources/asset_card_datasource.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/category.dart';
import 'package:musical_note_training/shared/domain/models/lesson.dart';
import 'package:musical_note_training/shared/domain/repositories/card_repository.dart';

class AssetCardRepository implements CardRepository {
  AssetCardRepository({AssetCardDatasource? datasource})
      : _datasource = datasource ?? const AssetCardDatasource();

  final AssetCardDatasource _datasource;
  final Map<String, _CachedBundle> _cache = {};

  @override
  Future<List<Category>> getCategories() => _datasource.loadCategories();

  @override
  Future<List<Lesson>> getLessons(String categoryId) async {
    final bundle = await _bundleFor(categoryId);
    return bundle.lessons.where((l) => l.categoryId == categoryId).toList();
  }

  @override
  Future<List<Card>> getCardsByLesson(String lessonId) async {
    for (final categoryId in ContentAssets.categoryBundles.keys) {
      final bundle = await _bundleFor(categoryId);
      final cards =
          bundle.cards.where((c) => c.lessonId == lessonId).toList();
      if (cards.isNotEmpty) return cards;
    }
    return [];
  }

  @override
  Future<List<Card>> getCardsByCategory(CardCategoryType type) async {
    final categories = await getCategories();
    Category? category;
    for (final c in categories) {
      if (c.type == type) {
        category = c;
        break;
      }
    }
    if (category == null) return [];
    final bundle = await _bundleFor(category.id);
    return bundle.cards.where((c) => c.categoryType == type).toList();
  }

  @override
  Future<Card?> getCardById(String id) async {
    for (final categoryId in ContentAssets.categoryBundles.keys) {
      final bundle = await _bundleFor(categoryId);
      for (final card in bundle.cards) {
        if (card.id == id) return card;
      }
    }
    return null;
  }

  Future<_CachedBundle> _bundleFor(String categoryId) async {
    final cached = _cache[categoryId];
    if (cached != null) return cached;

    final raw = await _datasource.loadCategoryBundle(categoryId);
    final bundle = _CachedBundle(
      lessons: raw.lessons,
      cards: raw.cards,
    );
    _cache[categoryId] = bundle;
    return bundle;
  }
}

class _CachedBundle {
  const _CachedBundle({required this.lessons, required this.cards});

  final List<Lesson> lessons;
  final List<Card> cards;
}