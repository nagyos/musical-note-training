/// SMuFL symbol glyphs (Bravura) keyed by seed content mark id.
abstract final class SymbolMarkGlyph {
  static const Map<String, int> smuflCodepoints = {
    'sharp': 0xE262,
    'flat': 0xE260,
    'natural': 0xE261,
    'fermata': 0xE4C0,
    'repeatStart': 0xE040,
    'repeatEnd': 0xE041,
  };

  static const seedCardMarks = {
    'symbol-sharp': 'sharp',
    'symbol-flat': 'flat',
    'symbol-natural': 'natural',
    'symbol-fermata': 'fermata',
    'symbol-repeat-start': 'repeatStart',
    'symbol-repeat-end': 'repeatEnd',
  };

  static int? codepointForMark(String mark) => smuflCodepoints[mark];

  static String? markForCardId(String cardId) => seedCardMarks[cardId];
}