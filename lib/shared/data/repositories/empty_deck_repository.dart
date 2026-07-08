import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';
import 'package:musical_note_training/shared/domain/repositories/deck_repository.dart';

/// Placeholder until deck feature lands (issue/4).
class EmptyDeckRepository implements DeckRepository {
  const EmptyDeckRepository();

  @override
  Future<void> addCardToDeck({
    required String deckId,
    required String cardId,
  }) async {}

  @override
  Future<Deck> createDeck({required String name, String? description}) async {
    throw UnsupportedError('DeckRepository is not available yet');
  }

  @override
  Future<void> deleteDeck(String id) async {}

  @override
  Future<Deck?> getDeckById(String id) async => null;

  @override
  Future<List<DeckCard>> getDeckCards(String deckId) async => [];

  @override
  Future<List<Deck>> getDecks() async => [];

  @override
  Future<void> removeCardFromDeck({
    required String deckId,
    required String cardId,
  }) async {}

  @override
  Future<Deck> updateDeck(Deck deck) async => deck;
}