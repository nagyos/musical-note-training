/// Fixed diatonic answer choices for note study sessions.
abstract final class StudyAnswerChoices {
  static const solfege = ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'];
  static const letters = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  /// Vertical row per index (0 = top, 1 = bottom). Even steps low (C E G B),
  /// odd steps high (D F A), left to right.
  static const zigzagRows = [1, 0, 1, 0, 1, 0, 1];

  static List<String> forLocale(String locale) {
    return locale == 'en' ? List.unmodifiable(letters) : List.unmodifiable(solfege);
  }
}