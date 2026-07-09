/// Italian tempo marks for score-style Bravura rendering (seed content).
abstract final class TempoMarkGlyph {
  /// Engraved score text shown in the question area (not the answer label).
  static const Map<String, String> scoreText = {
    'largo': 'Largo',
    'andante': 'Andante',
    'moderato': 'Moderato',
    'allegro': 'Allegro',
    'presto': 'Presto',
  };

  static const seedCardMarks = {
    'tempo-largo': 'largo',
    'tempo-andante': 'andante',
    'tempo-moderato': 'moderato',
    'tempo-allegro': 'allegro',
    'tempo-presto': 'presto',
  };

  static String? scoreTextForMark(String mark) => scoreText[mark];

  static String? markForCardId(String cardId) => seedCardMarks[cardId];
}