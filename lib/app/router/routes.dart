/// Central route path definitions for [go_router] (T-003).
abstract final class AppRoutes {
  static const home = '/';
  static const catalog = '/catalog';
  static String catalogCategory(String categoryId) => '$catalog/$categoryId';

  static const study = '/study';
  static String studyLesson(String lessonId) => '$study?lessonId=$lessonId';
  static const decks = '/decks';
  static String deckDetail(String deckId) => '$decks/$deckId';
  static String deckAddCards(String deckId) => '$decks/$deckId/cards/add';

  static String studyDeck(String deckId) => '$study?deckId=$deckId';
  static const studyWeakItems = '$study?source=weak';
  static const weakItems = '/weak-items';
  static const settings = '/settings';

  // Phase 2+
  static const flash = '/flash';
  static const rhythm = '/rhythm';
  static const customCard = '/custom-card';
}
