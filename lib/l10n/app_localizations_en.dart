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

  @override
  String get settingsBackupTitle => 'Data backup';

  @override
  String get backupGoogleNotLinked =>
      'Google account not linked (data won\'t transfer across devices)';

  @override
  String get backupGoogleUnavailableDesktop =>
      'Google link and auto-sync are available on Android and iOS. On this device, only export / import is supported.';

  @override
  String backupGoogleLinked(String email) {
    return 'Linked: $email';
  }

  @override
  String get backupGoogleSignIn => 'Link with Google';

  @override
  String get backupGoogleSignOut => 'Unlink Google';

  @override
  String get backupGoogleSignedOut => 'Google account unlinked';

  @override
  String get backupGoogleSignInFailed => 'Failed to link Google account';

  @override
  String get backupSyncNow => 'Sync now';

  @override
  String get backupSyncSuccess => 'Sync completed';

  @override
  String backupSyncFailed(String error) {
    return 'Sync failed: $error';
  }

  @override
  String get backupExportShare => 'Export learning backup (share)';

  @override
  String get backupExportSaveFile => 'Export learning backup';

  @override
  String get backupExportShareSubject => 'Musical Note Training backup';

  @override
  String get backupExportSuccess => 'Export completed';

  @override
  String backupExportSaved(String path) {
    return 'File saved: $path';
  }

  @override
  String backupExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get backupImportPickFile => 'Import backup file';

  @override
  String get backupImportConfirmTitle => 'Import this backup?';

  @override
  String get backupImportConfirmScopeTitle => 'What is included';

  @override
  String get backupImportConfirmScopeBody =>
      '· Decks you created\n· Weak items\n· Lesson study progress\n· Display settings (language, note names)\n\nOfficial catalog cards (built into the app) are not included.';

  @override
  String get backupImportConfirmWarning =>
      'Any current records in the list above that are not in the backup will be removed. This cannot be undone.';

  @override
  String get backupImportConfirmCountHeader =>
      'Count changes (now → after import)';

  @override
  String get backupImportConfirmCountDecks => 'Decks';

  @override
  String get backupImportConfirmCountWeak => 'Weak';

  @override
  String get backupImportConfirmCountProgress => 'Progress';

  @override
  String backupImportConfirmCountLine(int current, int after) {
    return '$current → $after';
  }

  @override
  String backupImportConfirmDeltaPlus(int count) {
    return '+$count';
  }

  @override
  String backupImportConfirmDeltaMinus(int count) {
    return '$count';
  }

  @override
  String get backupImportConfirmDeltaZero => '±0';

  @override
  String get backupImportConfirmSettingsTitle => 'Display setting changes';

  @override
  String backupImportConfirmSettingsLocale(String from, String to) {
    return 'Language: $from → $to';
  }

  @override
  String backupImportConfirmSettingsNoteNames(String from, String to) {
    return 'Note names: $from → $to';
  }

  @override
  String backupImportConfirmExportedAt(String exportedAt) {
    return 'Backup created: $exportedAt';
  }

  @override
  String get backupImportConfirmApply => 'Import';

  @override
  String get backupImportSuccess => 'Import completed';

  @override
  String backupImportFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get backupHelpLink => 'How to transfer data';

  @override
  String get backupHelpTitle => 'Data transfer guide';

  @override
  String get backupHelpGoogleSection => 'Recommended: Google link';

  @override
  String get backupHelpGoogleBody =>
      '1. Tap \"Link with Google\" in Settings\n2. Sign in with the same account on another device\n3. Data syncs on launch, or tap \"Sync now\"';

  @override
  String get backupHelpExportSection => 'Manual backup (fallback)';

  @override
  String get backupHelpExportBody =>
      '1. Tap \"Export learning backup\" to create a backup file (JSON)\n2. Send it to your new device (email, cloud storage, etc.)\n3. On the new device, tap \"Import backup file\" and choose it';

  @override
  String get backupHelpImportSection => 'About import';

  @override
  String get backupHelpImportBody =>
      'The selected backup file replaces this device\'s decks, weak items, and progress (same for moving to a new device).';

  @override
  String get backupHelpClose => 'Close';

  @override
  String get onboardingGoogleTitle => 'Protect your data with Google';

  @override
  String get onboardingGoogleBody =>
      'Your study data is backed up to Google Drive automatically. Use the same progress across devices or after changing phones.';

  @override
  String get onboardingGoogleBenefit =>
      'You can link Google later from Settings.';

  @override
  String get onboardingGoogleSignIn => 'Link with Google';

  @override
  String get onboardingGoogleSkip => 'Later (stay as guest)';
}
