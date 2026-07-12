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
  String get noCategories => 'カテゴリーがありません';

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
  String studyResultScore(int correct, int total) {
    return '$correct / $total 問正解';
  }

  @override
  String get studyWrongAnswersTitle => '間違えた問題';

  @override
  String studyWrongAnswerLine(String selected, String correct) {
    return 'あなたの回答: $selected → 正解: $correct';
  }

  @override
  String get studyRetry => 'もう一度';

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

  @override
  String get settingsBackupTitle => 'データのバックアップ';

  @override
  String get backupGoogleNotLinked => 'Google アカウント未連携（端末変更時にデータを引き継げません）';

  @override
  String get backupGoogleUnavailableDesktop =>
      'Google 連携・自動同期は Android / iOS で利用できます。この端末ではエクスポート / インポートのみ利用可能です。';

  @override
  String backupGoogleLinked(String email) {
    return '連携中: $email';
  }

  @override
  String get backupGoogleSignIn => 'Google で連携';

  @override
  String get backupGoogleSignOut => '連携を解除';

  @override
  String get backupGoogleSignedOut => 'Google 連携を解除しました';

  @override
  String get backupGoogleSignInFailed => 'Google 連携に失敗しました';

  @override
  String get backupSyncNow => '今すぐ同期';

  @override
  String get backupSyncSuccess => '同期が完了しました';

  @override
  String backupSyncFailed(String error) {
    return '同期に失敗しました: $error';
  }

  @override
  String get backupExportShare => '学習記録のバックアップをエクスポート（共有）';

  @override
  String get backupExportSaveFile => '学習記録のバックアップをエクスポート';

  @override
  String get backupExportShareSubject => 'Musical Note Training バックアップ';

  @override
  String get backupExportSuccess => 'エクスポートしました';

  @override
  String backupExportSaved(String path) {
    return 'ファイルを保存しました: $path';
  }

  @override
  String backupExportFailed(String error) {
    return 'エクスポートに失敗しました: $error';
  }

  @override
  String get backupImportPickFile => 'バックアップをインポート';

  @override
  String get backupImportConfirmTitle => 'バックアップをインポートしますか？';

  @override
  String get backupImportConfirmScopeTitle => 'バックアップの対象';

  @override
  String get backupImportConfirmScopeBody =>
      '・単語帳（自分で作ったデッキ）\n・苦手の記録\n・レッスンの学習進捗\n・表示設定（言語・音名）\n\n公式の学習カード（アプリ本体の内容）は含みません。';

  @override
  String get backupImportConfirmWarning =>
      '上記のうち、バックアップに含まれない現在の記録は消えます。この操作は取り消せません。';

  @override
  String get backupImportConfirmCountHeader => '件数の変化（現在 → インポート後）';

  @override
  String get backupImportConfirmCountDecks => '単語帳';

  @override
  String get backupImportConfirmCountWeak => '苦手';

  @override
  String get backupImportConfirmCountProgress => '学習進捗';

  @override
  String backupImportConfirmCountLine(int current, int after) {
    return '$current件 → $after件';
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
  String get backupImportConfirmSettingsTitle => '表示設定の変化';

  @override
  String backupImportConfirmSettingsLocale(String from, String to) {
    return '言語: $from → $to';
  }

  @override
  String backupImportConfirmSettingsNoteNames(String from, String to) {
    return '音名: $from → $to';
  }

  @override
  String backupImportConfirmExportedAt(String exportedAt) {
    return 'バックアップ作成: $exportedAt';
  }

  @override
  String get backupImportConfirmApply => 'インポート';

  @override
  String get backupImportSuccess => 'インポートが完了しました';

  @override
  String backupImportFailed(String error) {
    return 'インポートに失敗しました: $error';
  }

  @override
  String get backupHelpLink => '引き継ぎの手順を見る';

  @override
  String get backupHelpTitle => 'データ引き継ぎの手順';

  @override
  String get backupHelpGoogleSection => 'おすすめ: Google 連携';

  @override
  String get backupHelpGoogleBody =>
      '1. 設定で「Google で連携」をタップ\n2. 同じ Google アカウントで別端末にもログイン\n3. 起動時に自動同期、または「今すぐ同期」をタップ';

  @override
  String get backupHelpExportSection => '手動バックアップ（補助）';

  @override
  String get backupHelpExportBody =>
      '1. 「学習記録のバックアップをエクスポート」でバックアップファイル（JSON）を作成\n2. メールやクラウドストレージで新端末へ送る\n3. 新端末で「バックアップをインポート」からそのファイルを選ぶ';

  @override
  String get backupHelpImportSection => '取り込みについて';

  @override
  String get backupHelpImportBody =>
      '選んだバックアップファイルの記録で、この端末のデッキ・苦手・進捗を置き換えます（新端末への引き継ぎも同じ操作です）。';

  @override
  String get backupHelpClose => '閉じる';

  @override
  String get onboardingGoogleTitle => 'Google でデータを守る';

  @override
  String get onboardingGoogleBody =>
      '学習データを Google Drive に自動バックアップします。機種変更や複数端末でも同じ進捗を使えます。';

  @override
  String get onboardingGoogleBenefit => 'あとから設定画面でも連携できます。';

  @override
  String get onboardingGoogleSignIn => 'Google で連携する';

  @override
  String get onboardingGoogleSkip => 'あとで（ゲストのまま）';
}
