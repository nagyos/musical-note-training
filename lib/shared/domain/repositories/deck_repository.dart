import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';

abstract class DeckRepository {
  Future<List<Deck>> getDecks();

  Future<Deck?> getDeckById(String id);

  Future<Deck> createDeck({required String name, String? description});

  Future<Deck> updateDeck(Deck deck);

  Future<void> deleteDeck(String id);

  Future<List<DeckCard>> getDeckCards(String deckId);

  Future<void> addCardToDeck({
    required String deckId,
    required String cardId,
  });

  Future<void> removeCardFromDeck({
    required String deckId,
    required String cardId,
  });
}