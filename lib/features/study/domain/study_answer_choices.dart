import 'package:musical_note_training/shared/domain/models/card_category_type.dart';

/// Fixed answer choices per official content category.
abstract final class StudyAnswerChoices {
  static const solfege = ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'];
  static const letters = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  static const restsJa = [
    '全休符',
    '二分休符',
    '四分休符',
    '八分休符',
    '十六分休符',
  ];

  static const restsEn = [
    'Whole rest',
    'Half rest',
    'Quarter rest',
    'Eighth rest',
    'Sixteenth rest',
  ];

  static const dynamicsJa = [
    'ピアノ（弱く）',
    'ミーツォピアノ（少し弱く）',
    'ミーツォフォルテ（少し強く）',
    'フォルテ（強く）',
    'フォルティッシモ（非常に強く）',
  ];
  static const dynamicsEn = [
    'Piano (Soft)',
    'Mezzo piano (Moderately soft)',
    'Mezzo forte (Moderately loud)',
    'Forte (Loud)',
    'Fortissimo (Very loud)',
  ];

  static const symbolsJa = [
    'シャープ（音を半音高める）',
    'フラット（音を半音低める）',
    'ナチュラル（元来の高さに戻す）',
    'フェルマータ（その音を伸ばす）',
    'リピート始め（ここから繰り返す）',
    'リピート終わり（始めに戻って繰り返す）',
  ];
  static const symbolsEn = [
    'Sharp (Raises by a semitone)',
    'Flat (Lowers by a semitone)',
    'Natural (Cancels an accidental)',
    'Fermata (Hold the note longer)',
    'Repeat start (Repeat from here)',
    'Repeat end (Go back and repeat)',
  ];

  static const temposJa = [
    '幅広くゆるやかに',
    '歩くような速さで',
    '中くらいの速さで',
    '快速に・陽気に',
    '極めて速く',
  ];
  static const temposEn = [
    'Very slow and broad',
    'At a walking pace',
    'At a moderate tempo',
    'Fast and lively',
    'Very fast',
  ];

  /// True for the upper row; false for the lower row (zigzag left to right).
  static bool isTopRow(int index) => index.isOdd;

  /// Notes follow [noteAnswerLocale] (solfege vs letter names).
  /// Tempo, dynamic, and symbol choices follow [uiLocale].
  static String localeForCategory({
    required CardCategoryType category,
    required String noteAnswerLocale,
    required String uiLocale,
  }) =>
      switch (category) {
        CardCategoryType.note => noteAnswerLocale,
        _ => uiLocale,
      };

  static List<String> forCategory(CardCategoryType category, String locale) {
    final isEn = locale == 'en';
    return switch (category) {
      CardCategoryType.note =>
        List.unmodifiable(isEn ? letters : solfege),
      CardCategoryType.rest =>
        List.unmodifiable(isEn ? restsEn : restsJa),
      CardCategoryType.dynamic =>
        List.unmodifiable(isEn ? dynamicsEn : dynamicsJa),
      CardCategoryType.symbol =>
        List.unmodifiable(isEn ? symbolsEn : symbolsJa),
      CardCategoryType.tempo =>
        List.unmodifiable(isEn ? temposEn : temposJa),
    };
  }

  static bool usesZigzagLayout(CardCategoryType category) =>
      category == CardCategoryType.note;
}