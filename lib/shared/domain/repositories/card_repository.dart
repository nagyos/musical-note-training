import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/category.dart';
import 'package:musical_note_training/shared/domain/models/lesson.dart';

abstract class CardRepository {
  Future<List<Category>> getCategories();

  Future<List<Lesson>> getLessons(String categoryId);

  Future<List<Card>> getCardsByLesson(String lessonId);

  Future<List<Card>> getCardsByCategory(CardCategoryType type);

  Future<Card?> getCardById(String id);
}