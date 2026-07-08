import 'package:musical_note_training/features/study/domain/study_launch_target.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/repositories/card_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/deck_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';

/// Resolves study cards from catalog lessons, decks, or weak items.
class StudyLaunchService {
  const StudyLaunchService({
    required this.cardRepository,
    required this.deckRepository,
    required this.weakItemRepository,
  });

  final CardRepository cardRepository;
  final DeckRepository deckRepository;
  final WeakItemRepository weakItemRepository;

  Future<List<Card>> loadCards(StudyLaunchTarget target) {
    return switch (target) {
      LessonLaunchTarget(:final lessonId) =>
        cardRepository.getCardsByLesson(lessonId),
      DeckLaunchTarget(:final deckId) => _loadDeckCards(deckId),
      WeakItemsLaunchTarget() => _loadWeakItemCards(),
    };
  }

  Future<List<Card>> _loadWeakItemCards() async {
    final weakItems = await weakItemRepository.getWeakItems();
    final cards = <Card>[];
    for (final weakItem in weakItems) {
      final card = await cardRepository.getCardById(weakItem.cardId);
      if (card != null) cards.add(card);
    }
    return cards;
  }

  Future<List<Card>> _loadDeckCards(String deckId) async {
    final deckCards = await deckRepository.getDeckCards(deckId);
    final sorted = List.of(deckCards)
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    final cards = <Card>[];
    for (final deckCard in sorted) {
      final card = await cardRepository.getCardById(deckCard.cardId);
      if (card != null) cards.add(card);
    }
    return cards;
  }
}