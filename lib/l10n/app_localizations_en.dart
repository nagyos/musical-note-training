// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Musical Note Training';

  @override
  String get decksTooltip => 'Decks';

  @override
  String get weakItemsTooltip => 'Weak items';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String loadFailed(String error) {
    return 'Failed to load: $error';
  }

  @override
  String get noCategories => 'No categories';

  @override
  String loadLessonsFailed(String error) {
    return 'Failed to load lessons: $error';
  }

  @override
  String get noLessonsYet => 'No lessons yet';

  @override
  String get studyTitle => 'Study';

  @override
  String studyProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get studyQuestionPrompt => 'What is this note?';

  @override
  String get answerCorrect => 'Correct!';

  @override
  String get answerIncorrect => 'Incorrect';

  @override
  String correctAnswerLabel(String answer) {
    return 'Answer: $answer';
  }

  @override
  String get studyNext => 'Next';

  @override
  String get studySeeResults => 'See results';

  @override
  String get studySessionComplete => 'Session complete';

  @override
  String studyResultScore(int correct, int total) {
    return '$correct / $total correct';
  }

  @override
  String get studyWrongAnswersTitle => 'Missed questions';

  @override
  String studyWrongAnswerLine(String selected, String correct) {
    return 'Your answer: $selected → Correct: $correct';
  }

  @override
  String get studyRetry => 'Try again';

  @override
  String studyQuestionsFinished(int count) {
    return 'Finished $count questions';
  }

  @override
  String get back => 'Back';

  @override
  String get invalidStudyParameters => 'Invalid study parameters';

  @override
  String get weakItemsTitle => 'Weak items';

  @override
  String get noWeakItems =>
      'No weak items yet.\nThey are added automatically when you answer incorrectly.';

  @override
  String reviewWeakItems(int count) {
    return 'Review weak items ($count)';
  }

  @override
  String weakItemStats(int wrong, int correct, int accuracy) {
    return 'Wrong $wrong / Correct $correct ($accuracy%)';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageJa => 'Japanese';

  @override
  String get settingsLanguageEn => 'English';

  @override
  String get settingsNoteNames => 'Note names';

  @override
  String get settingsNoteNamesSolfege => 'Solfege (Do Re Mi)';

  @override
  String get settingsNoteNamesLetter => 'Letter names (C D E)';

  @override
  String get decksTitle => 'Decks';

  @override
  String loadDecksFailed(String error) {
    return 'Failed to load decks: $error';
  }

  @override
  String get noDecksHint => 'No decks yet. Tap + to create one.';

  @override
  String get newDeckTitle => 'New deck';

  @override
  String get deckNameHint => 'Deck name';

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get deckFallbackTitle => 'Deck';

  @override
  String get addCards => 'Add cards';

  @override
  String loadDeckCardsFailed(String error) {
    return 'Failed to load cards: $error';
  }

  @override
  String studyDeck(int count) {
    return 'Study ($count cards)';
  }

  @override
  String get noCardsInDeck => 'No cards in this deck';

  @override
  String get deleteDeckTitle => 'Delete deck';

  @override
  String get deleteDeckMessage => 'Delete this deck?';

  @override
  String get delete => 'Delete';

  @override
  String get addOfficialCardsTitle => 'Add official cards';

  @override
  String get add => 'Add';

  @override
  String get cardAlreadyAdded => 'Added';

  @override
  String get selectCategoryFromHome => 'Select a category from Home';

  @override
  String get routeNotFound => 'Not found';

  @override
  String routeNotFoundMessage(String uri) {
    return 'No route for $uri';
  }
}
