/// SMuFL rest glyphs (Bravura) keyed by seed content mark id.
abstract final class RestMarkGlyph {
  static const Map<String, int> smuflCodepoints = {
    'whole': 0xE4E3,
    'half': 0xE4E4,
    'quarter': 0xE4E5,
    'eighth': 0xE4E6,
    'sixteenth': 0xE4E7,
  };

  static const seedCardMarks = {
    'rest-whole': 'whole',
    'rest-half': 'half',
    'rest-quarter': 'quarter',
    'rest-eighth': 'eighth',
    'rest-sixteenth': 'sixteenth',
  };

  static int? codepointForMark(String mark) => smuflCodepoints[mark];

  static String? markForCardId(String cardId) => seedCardMarks[cardId];
}