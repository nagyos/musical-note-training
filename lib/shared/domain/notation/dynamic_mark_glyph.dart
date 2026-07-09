/// SMuFL dynamic mark glyphs (Bravura) keyed by seed content mark id.
abstract final class DynamicMarkGlyph {
  static const Map<String, int> smuflCodepoints = {
    'p': 0xE520,
    'mp': 0xE52B,
    'mf': 0xE52D,
    'f': 0xE522,
    'ff': 0xE52F,
  };

  static const seedCardMarks = {
    'dynamic-p': 'p',
    'dynamic-mp': 'mp',
    'dynamic-mf': 'mf',
    'dynamic-f': 'f',
    'dynamic-ff': 'ff',
  };

  static int? codepointForMark(String mark) => smuflCodepoints[mark];

  static String? markForCardId(String cardId) => seedCardMarks[cardId];
}