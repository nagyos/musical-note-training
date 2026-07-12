import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Musical Note Training'**
  String get appTitle;

  /// No description provided for @decksTooltip.
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get decksTooltip;

  /// No description provided for @weakItemsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Weak items'**
  String get weakItemsTooltip;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load: {error}'**
  String loadFailed(String error);

  /// No description provided for @noCategories.
  ///
  /// In en, this message translates to:
  /// **'No categories'**
  String get noCategories;

  /// No description provided for @loadLessonsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load lessons: {error}'**
  String loadLessonsFailed(String error);

  /// No description provided for @noLessonsYet.
  ///
  /// In en, this message translates to:
  /// **'No lessons yet'**
  String get noLessonsYet;

  /// No description provided for @studyTitle.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get studyTitle;

  /// No description provided for @studyProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String studyProgress(int current, int total);

  /// No description provided for @studyQuestionPrompt.
  ///
  /// In en, this message translates to:
  /// **'What is this note?'**
  String get studyQuestionPrompt;

  /// No description provided for @answerCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get answerCorrect;

  /// No description provided for @answerIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get answerIncorrect;

  /// No description provided for @correctAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Answer: {answer}'**
  String correctAnswerLabel(String answer);

  /// No description provided for @studyNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get studyNext;

  /// No description provided for @studySeeResults.
  ///
  /// In en, this message translates to:
  /// **'See results'**
  String get studySeeResults;

  /// No description provided for @studySessionComplete.
  ///
  /// In en, this message translates to:
  /// **'Session complete'**
  String get studySessionComplete;

  /// No description provided for @studyResultScore.
  ///
  /// In en, this message translates to:
  /// **'{correct} / {total} correct'**
  String studyResultScore(int correct, int total);

  /// No description provided for @studyWrongAnswersTitle.
  ///
  /// In en, this message translates to:
  /// **'Missed questions'**
  String get studyWrongAnswersTitle;

  /// No description provided for @studyWrongAnswerLine.
  ///
  /// In en, this message translates to:
  /// **'Your answer: {selected} → Correct: {correct}'**
  String studyWrongAnswerLine(String selected, String correct);

  /// No description provided for @studyRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get studyRetry;

  /// No description provided for @studyQuestionsFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished {count} questions'**
  String studyQuestionsFinished(int count);

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @invalidStudyParameters.
  ///
  /// In en, this message translates to:
  /// **'Invalid study parameters'**
  String get invalidStudyParameters;

  /// No description provided for @weakItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Weak items'**
  String get weakItemsTitle;

  /// No description provided for @noWeakItems.
  ///
  /// In en, this message translates to:
  /// **'No weak items yet.\nThey are added automatically when you answer incorrectly.'**
  String get noWeakItems;

  /// No description provided for @reviewWeakItems.
  ///
  /// In en, this message translates to:
  /// **'Review weak items ({count})'**
  String reviewWeakItems(int count);

  /// No description provided for @weakItemStats.
  ///
  /// In en, this message translates to:
  /// **'Wrong {wrong} / Correct {correct} ({accuracy}%)'**
  String weakItemStats(int wrong, int correct, int accuracy);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageJa.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get settingsLanguageJa;

  /// No description provided for @settingsLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEn;

  /// No description provided for @settingsNoteNames.
  ///
  /// In en, this message translates to:
  /// **'Note names'**
  String get settingsNoteNames;

  /// No description provided for @settingsNoteNamesSolfege.
  ///
  /// In en, this message translates to:
  /// **'Solfege (Do Re Mi)'**
  String get settingsNoteNamesSolfege;

  /// No description provided for @settingsNoteNamesLetter.
  ///
  /// In en, this message translates to:
  /// **'Letter names (C D E)'**
  String get settingsNoteNamesLetter;

  /// No description provided for @decksTitle.
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get decksTitle;

  /// No description provided for @loadDecksFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load decks: {error}'**
  String loadDecksFailed(String error);

  /// No description provided for @noDecksHint.
  ///
  /// In en, this message translates to:
  /// **'No decks yet. Tap + to create one.'**
  String get noDecksHint;

  /// No description provided for @newDeckTitle.
  ///
  /// In en, this message translates to:
  /// **'New deck'**
  String get newDeckTitle;

  /// No description provided for @deckNameHint.
  ///
  /// In en, this message translates to:
  /// **'Deck name'**
  String get deckNameHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @deckFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Deck'**
  String get deckFallbackTitle;

  /// No description provided for @addCards.
  ///
  /// In en, this message translates to:
  /// **'Add cards'**
  String get addCards;

  /// No description provided for @loadDeckCardsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load cards: {error}'**
  String loadDeckCardsFailed(String error);

  /// No description provided for @studyDeck.
  ///
  /// In en, this message translates to:
  /// **'Study ({count} cards)'**
  String studyDeck(int count);

  /// No description provided for @noCardsInDeck.
  ///
  /// In en, this message translates to:
  /// **'No cards in this deck'**
  String get noCardsInDeck;

  /// No description provided for @deleteDeckTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete deck'**
  String get deleteDeckTitle;

  /// No description provided for @deleteDeckMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete this deck?'**
  String get deleteDeckMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @addOfficialCardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Add official cards'**
  String get addOfficialCardsTitle;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @cardAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get cardAlreadyAdded;

  /// No description provided for @selectCategoryFromHome.
  ///
  /// In en, this message translates to:
  /// **'Select a category from Home'**
  String get selectCategoryFromHome;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get routeNotFound;

  /// No description provided for @routeNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No route for {uri}'**
  String routeNotFoundMessage(String uri);

  /// No description provided for @settingsBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Data backup'**
  String get settingsBackupTitle;

  /// No description provided for @backupGoogleNotLinked.
  ///
  /// In en, this message translates to:
  /// **'Google account not linked (data won\'t transfer across devices)'**
  String get backupGoogleNotLinked;

  /// No description provided for @backupGoogleUnavailableDesktop.
  ///
  /// In en, this message translates to:
  /// **'Google link and auto-sync are available on Android and iOS. On this device, only export / import is supported.'**
  String get backupGoogleUnavailableDesktop;

  /// No description provided for @backupGoogleLinked.
  ///
  /// In en, this message translates to:
  /// **'Linked: {email}'**
  String backupGoogleLinked(String email);

  /// No description provided for @backupGoogleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Link with Google'**
  String get backupGoogleSignIn;

  /// No description provided for @backupGoogleSignOut.
  ///
  /// In en, this message translates to:
  /// **'Unlink Google'**
  String get backupGoogleSignOut;

  /// No description provided for @backupGoogleSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Google account unlinked'**
  String get backupGoogleSignedOut;

  /// No description provided for @backupGoogleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to link Google account'**
  String get backupGoogleSignInFailed;

  /// No description provided for @backupSyncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get backupSyncNow;

  /// No description provided for @backupSyncSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sync completed'**
  String get backupSyncSuccess;

  /// No description provided for @backupSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed: {error}'**
  String backupSyncFailed(String error);

  /// No description provided for @backupExportShare.
  ///
  /// In en, this message translates to:
  /// **'Export learning backup (share)'**
  String get backupExportShare;

  /// No description provided for @backupExportSaveFile.
  ///
  /// In en, this message translates to:
  /// **'Export learning backup'**
  String get backupExportSaveFile;

  /// No description provided for @backupExportShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Musical Note Training backup'**
  String get backupExportShareSubject;

  /// No description provided for @backupExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export completed'**
  String get backupExportSuccess;

  /// No description provided for @backupExportSaved.
  ///
  /// In en, this message translates to:
  /// **'File saved: {path}'**
  String backupExportSaved(String path);

  /// No description provided for @backupExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String backupExportFailed(String error);

  /// No description provided for @backupImportPickFile.
  ///
  /// In en, this message translates to:
  /// **'Import backup file'**
  String get backupImportPickFile;

  /// No description provided for @backupImportConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Import this backup?'**
  String get backupImportConfirmTitle;

  /// No description provided for @backupImportConfirmScopeTitle.
  ///
  /// In en, this message translates to:
  /// **'What is included'**
  String get backupImportConfirmScopeTitle;

  /// No description provided for @backupImportConfirmScopeBody.
  ///
  /// In en, this message translates to:
  /// **'· Decks you created\n· Weak items\n· Lesson study progress\n· Display settings (language, note names)\n\nOfficial catalog cards (built into the app) are not included.'**
  String get backupImportConfirmScopeBody;

  /// No description provided for @backupImportConfirmWarning.
  ///
  /// In en, this message translates to:
  /// **'Any current records in the list above that are not in the backup will be removed. This cannot be undone.'**
  String get backupImportConfirmWarning;

  /// No description provided for @backupImportConfirmCountHeader.
  ///
  /// In en, this message translates to:
  /// **'Count changes (now → after import)'**
  String get backupImportConfirmCountHeader;

  /// No description provided for @backupImportConfirmCountDecks.
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get backupImportConfirmCountDecks;

  /// No description provided for @backupImportConfirmCountWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get backupImportConfirmCountWeak;

  /// No description provided for @backupImportConfirmCountProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get backupImportConfirmCountProgress;

  /// No description provided for @backupImportConfirmCountLine.
  ///
  /// In en, this message translates to:
  /// **'{current} → {after}'**
  String backupImportConfirmCountLine(int current, int after);

  /// No description provided for @backupImportConfirmDeltaPlus.
  ///
  /// In en, this message translates to:
  /// **'+{count}'**
  String backupImportConfirmDeltaPlus(int count);

  /// No description provided for @backupImportConfirmDeltaMinus.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String backupImportConfirmDeltaMinus(int count);

  /// No description provided for @backupImportConfirmDeltaZero.
  ///
  /// In en, this message translates to:
  /// **'±0'**
  String get backupImportConfirmDeltaZero;

  /// No description provided for @backupImportConfirmSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Display setting changes'**
  String get backupImportConfirmSettingsTitle;

  /// No description provided for @backupImportConfirmSettingsLocale.
  ///
  /// In en, this message translates to:
  /// **'Language: {from} → {to}'**
  String backupImportConfirmSettingsLocale(String from, String to);

  /// No description provided for @backupImportConfirmSettingsNoteNames.
  ///
  /// In en, this message translates to:
  /// **'Note names: {from} → {to}'**
  String backupImportConfirmSettingsNoteNames(String from, String to);

  /// No description provided for @backupImportConfirmExportedAt.
  ///
  /// In en, this message translates to:
  /// **'Backup created: {exportedAt}'**
  String backupImportConfirmExportedAt(String exportedAt);

  /// No description provided for @backupImportConfirmApply.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get backupImportConfirmApply;

  /// No description provided for @backupImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import completed'**
  String get backupImportSuccess;

  /// No description provided for @backupImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String backupImportFailed(String error);

  /// No description provided for @backupHelpLink.
  ///
  /// In en, this message translates to:
  /// **'How to transfer data'**
  String get backupHelpLink;

  /// No description provided for @backupHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Data transfer guide'**
  String get backupHelpTitle;

  /// No description provided for @backupHelpGoogleSection.
  ///
  /// In en, this message translates to:
  /// **'Recommended: Google link'**
  String get backupHelpGoogleSection;

  /// No description provided for @backupHelpGoogleBody.
  ///
  /// In en, this message translates to:
  /// **'1. Tap \"Link with Google\" in Settings\n2. Sign in with the same account on another device\n3. Data syncs on launch, or tap \"Sync now\"'**
  String get backupHelpGoogleBody;

  /// No description provided for @backupHelpExportSection.
  ///
  /// In en, this message translates to:
  /// **'Manual backup (fallback)'**
  String get backupHelpExportSection;

  /// No description provided for @backupHelpExportBody.
  ///
  /// In en, this message translates to:
  /// **'1. Tap \"Export learning backup\" to create a backup file (JSON)\n2. Send it to your new device (email, cloud storage, etc.)\n3. On the new device, tap \"Import backup file\" and choose it'**
  String get backupHelpExportBody;

  /// No description provided for @backupHelpImportSection.
  ///
  /// In en, this message translates to:
  /// **'About import'**
  String get backupHelpImportSection;

  /// No description provided for @backupHelpImportBody.
  ///
  /// In en, this message translates to:
  /// **'The selected backup file replaces this device\'s decks, weak items, and progress (same for moving to a new device).'**
  String get backupHelpImportBody;

  /// No description provided for @backupHelpClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get backupHelpClose;

  /// No description provided for @onboardingGoogleTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect your data with Google'**
  String get onboardingGoogleTitle;

  /// No description provided for @onboardingGoogleBody.
  ///
  /// In en, this message translates to:
  /// **'Your study data is backed up to Google Drive automatically. Use the same progress across devices or after changing phones.'**
  String get onboardingGoogleBody;

  /// No description provided for @onboardingGoogleBenefit.
  ///
  /// In en, this message translates to:
  /// **'You can link Google later from Settings.'**
  String get onboardingGoogleBenefit;

  /// No description provided for @onboardingGoogleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Link with Google'**
  String get onboardingGoogleSignIn;

  /// No description provided for @onboardingGoogleSkip.
  ///
  /// In en, this message translates to:
  /// **'Later (stay as guest)'**
  String get onboardingGoogleSkip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
