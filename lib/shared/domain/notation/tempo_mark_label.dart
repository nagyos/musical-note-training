/// Display labels for tempo marks in seed content.
abstract final class TempoMarkLabel {
  static const Map<String, String> displayText = {
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

  static String? textForMark(String mark) => displayText[mark];

  static String? markForCardId(String cardId) => seedCardMarks[cardId];
}