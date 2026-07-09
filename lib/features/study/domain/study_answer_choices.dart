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
    'ピアノ',
    'ミーツォピアノ',
    'ミーツォフォルテ',
    'フォルテ',
    'フォルティッシモ',
  ];
  static const dynamicsEn = [
    'Piano',
    'Mezzo piano',
    'Mezzo forte',
    'Forte',
    'Fortissimo',
  ];
  static const symbolsJa = [
    'シャープ',
    'フラット',
    'ナチュラル',
    'フェルマータ',
    'リピート始め',
    'リピート終わり',
  ];
  static const symbolsEn = [
    'Sharp',
    'Flat',
    'Natural',
    'Fermata',
    'Repeat start',
    'Repeat end',
  ];

  /// True for the upper row; false for the lower row (zigzag left to right).
  static bool isTopRow(int index) => index.isOdd;

  /// Notes follow [noteAnswerLocale] (solfege vs letter names).
  /// Other categories follow [uiLocale] (app display language).
  static String localeForCategory({
    required CardCategoryType category,
    required String noteAnswerLocale,
    required String uiLocale,
  }) =>
      category == CardCategoryType.note ? noteAnswerLocale : uiLocale;

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
        throw UnsupportedError(
          'No fixed choices for category: ${category.name}',
        ),
    };
  }

  static bool usesZigzagLayout(CardCategoryType category) =>
      category == CardCategoryType.note;
}