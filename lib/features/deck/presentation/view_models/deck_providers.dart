import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';

final decksProvider = FutureProvider<List<Deck>>((ref) {
  return ref.read(deckRepositoryProvider).getDecks();
});

final deckProvider = FutureProvider.family<Deck?, String>((ref, deckId) {
  return ref.read(deckRepositoryProvider).getDeckById(deckId);
});

final deckCardsProvider =
    FutureProvider.family<List<DeckCard>, String>((ref, deckId) {
  return ref.read(deckRepositoryProvider).getDeckCards(deckId);
});

final deckResolvedCardsProvider =
    FutureProvider.family<List<Card>, String>((ref, deckId) async {
  final deckCards = await ref.watch(deckCardsProvider(deckId).future);
  final cardRepo = ref.read(cardRepositoryProvider);
  final cards = <Card>[];
  for (final deckCard in deckCards) {
    final card = await cardRepo.getCardById(deckCard.cardId);
    if (card != null) cards.add(card);
  }
  return cards;
});