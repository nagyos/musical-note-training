// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Musical Note Training';

  @override
  String get decksTooltip => '単語帳';

  @override
  String get weakItemsTooltip => '苦手';

  @override
  String get settingsTooltip => '設定';

  @override
  String loadFailed(String error) {
    return '読み込みに失敗しました: $error';
  }

  @override
  String get noCategories => 'No categories';

  @override
  String loadLessonsFailed(String error) {
    return 'レッスンの読み込みに失敗しました: $error';
  }

  @override
  String get noLessonsYet => 'レッスンがありません';

  @override
  String get studyTitle => '学習';

  @override
  String studyProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get studyQuestionPrompt => 'この音符の名前は？';

  @override
  String get answerCorrect => '正解！';

  @override
  String get answerIncorrect => '不正解';

  @override
  String correctAnswerLabel(String answer) {
    return '正解: $answer';
  }

  @override
  String get studyNext => '次へ';

  @override
  String get studySeeResults => '結果を見る';

  @override
  String get studySessionComplete => 'セッション完了';

  @override
  String studyQuestionsFinished(int count) {
    return '$count 問終了しました';
  }

  @override
  String get back => '戻る';

  @override
  String get invalidStudyParameters => '学習パラメータが不正です';

  @override
  String get weakItemsTitle => '苦手項目';

  @override
  String get noWeakItems => '苦手項目はまだありません。\n学習で間違えると自動追加されます。';

  @override
  String reviewWeakItems(int count) {
    return '苦手復習（$count 枚）';
  }

  @override
  String weakItemStats(int wrong, int correct, int accuracy) {
    return '誤答 $wrong / 正答 $correct（$accuracy%）';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '表示言語';

  @override
  String get settingsLanguageJa => '日本語';

  @override
  String get settingsLanguageEn => '英語';

  @override
  String get settingsNoteNames => '音名表示';

  @override
  String get settingsNoteNamesSolfege => 'ドレミ';

  @override
  String get settingsNoteNamesLetter => 'CDE';

  @override
  String get decksTitle => '単語帳';

  @override
  String loadDecksFailed(String error) {
    return 'デッキの読み込みに失敗しました: $error';
  }

  @override
  String get noDecksHint => 'デッキがありません。＋から作成';

  @override
  String get newDeckTitle => '新しいデッキ';

  @override
  String get deckNameHint => 'デッキ名';

  @override
  String get cancel => 'キャンセル';

  @override
  String get create => '作成';

  @override
  String get deckFallbackTitle => 'デッキ';

  @override
  String get addCards => 'カード追加';

  @override
  String loadDeckCardsFailed(String error) {
    return 'カードの読み込みに失敗しました: $error';
  }

  @override
  String studyDeck(int count) {
    return '学習する（$count 枚）';
  }

  @override
  String get noCardsInDeck => 'カードがありません';

  @override
  String get deleteDeckTitle => 'デッキを削除';

  @override
  String get deleteDeckMessage => 'このデッキを削除しますか？';

  @override
  String get delete => '削除';

  @override
  String get addOfficialCardsTitle => '公式カードから追加';

  @override
  String get add => '追加';

  @override
  String get cardAlreadyAdded => '追加済';

  @override
  String get selectCategoryFromHome => 'ホームからカテゴリーを選択してください';

  @override
  String get routeNotFound => 'ページが見つかりません';

  @override
  String routeNotFoundMessage(String uri) {
    return '$uri に対応するルートがありません';
  }
}
