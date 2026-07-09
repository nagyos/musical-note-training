/// Fixed diatonic answer choices for note study sessions.
abstract final class StudyAnswerChoices {
  static const solfege = ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'];
  static const letters = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  /// True for the upper row (D F A); false for the lower row (C E G B).
  static bool isTopRow(int index) => index.isOdd;

  static List<String> forLocale(String locale) {
    return locale == 'en' ? List.unmodifiable(letters) : List.unmodifiable(solfege);
  }
}