/// Fixed diatonic answer choices for note study sessions.
abstract final class StudyAnswerChoices {
  static const solfege = ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'];
  static const letters = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  /// Zigzag row per choice index (0 = top, 2 = bottom), like a staff contour.
  static const zigzagRows = [2, 1, 0, 1, 0, 1, 0];

  static List<String> forLocale(String locale) {
    return locale == 'en' ? List.unmodifiable(letters) : List.unmodifiable(solfege);
  }
}