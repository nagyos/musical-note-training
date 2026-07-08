/// Association between a [Deck] and a [Card].
class DeckCard {
  const DeckCard({
    required this.deckId,
    required this.cardId,
    required this.sortOrder,
    required this.addedAt,
  });

  final String deckId;
  final String cardId;
  final int sortOrder;
  final DateTime addedAt;
}