import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/study/domain/study_launch_service.dart';
import 'package:musical_note_training/features/study/domain/study_launch_target.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/category.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/lesson.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';
import 'package:musical_note_training/shared/domain/models/localized_text.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/repositories/card_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/deck_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

void main() {
  group('StudyLaunchService', () {
    late _FakeCardRepository cardRepo;
    late _FakeDeckRepository deckRepo;
    late _FakeWeakItemRepository weakRepo;
    late StudyLaunchService service;

    setUp(() {
      cardRepo = _FakeCardRepository();
      deckRepo = _FakeDeckRepository();
      weakRepo = _FakeWeakItemRepository();
      service = StudyLaunchService(
        cardRepository: cardRepo,
        deckRepository: deckRepo,
        weakItemRepository: weakRepo,
      );
    });

    test('loads cards for lesson target', () async {
      final lessonCards = [_card('note-c4')];
      cardRepo.lessonCards['note-middle-c'] = lessonCards;

      final result = await service.loadCards(
        const LessonLaunchTarget('note-middle-c'),
      );

      expect(result, lessonCards);
    });

    test('loads cards for deck target in sort order', () async {
      final c1 = _card('note-e4');
      final c2 = _card('note-c4');
      cardRepo.cards['note-e4'] = c1;
      cardRepo.cards['note-c4'] = c2;
      deckRepo.deckCards['deck-1'] = [
        DeckCard(
          deckId: 'deck-1',
          cardId: 'note-c4',
          sortOrder: 0,
          addedAt: DateTime.utc(2026, 7, 8),
        ),
        DeckCard(
          deckId: 'deck-1',
          cardId: 'note-e4',
          sortOrder: 1,
          addedAt: DateTime.utc(2026, 7, 8),
        ),
      ];

      final result = await service.loadCards(const DeckLaunchTarget('deck-1'));

      expect(result.map((c) => c.id), ['note-c4', 'note-e4']);
    });

    test('loads cards for weak items target', () async {
      final c1 = _card('note-c4');
      final c2 = _card('note-d4');
      cardRepo.cards['note-c4'] = c1;
      cardRepo.cards['note-d4'] = c2;
      weakRepo.cardIds = ['note-d4', 'note-c4'];

      final result =
          await service.loadCards(const WeakItemsLaunchTarget());

      expect(result.map((c) => c.id), ['note-d4', 'note-c4']);
    });

    test('skips missing cards in deck', () async {
      cardRepo.cards['note-c4'] = _card('note-c4');
      deckRepo.deckCards['deck-1'] = [
        DeckCard(
          deckId: 'deck-1',
          cardId: 'note-c4',
          sortOrder: 0,
          addedAt: DateTime.utc(2026, 7, 8),
        ),
        DeckCard(
          deckId: 'deck-1',
          cardId: 'missing',
          sortOrder: 1,
          addedAt: DateTime.utc(2026, 7, 8),
        ),
      ];

      final result = await service.loadCards(const DeckLaunchTarget('deck-1'));

      expect(result, hasLength(1));
      expect(result.first.id, 'note-c4');
    });
  });
}

Card _card(String id) {
  return Card(
    id: id,
    categoryType: CardCategoryType.note,
    lessonId: 'note-middle-c',
    answer: LocalizedText(values: {'ja': 'ド', 'en': 'C'}),
    sortOrder: 0,
    sync: SyncMetadata(version: 1, updatedAt: DateTime.utc(2026, 7, 8)),
  );
}

class _FakeCardRepository implements CardRepository {
  final lessonCards = <String, List<Card>>{};
  final cards = <String, Card>{};

  @override
  Future<Card?> getCardById(String id) async => cards[id];

  @override
  Future<List<Card>> getCardsByCategory(CardCategoryType type) async => [];

  @override
  Future<List<Card>> getCardsByLesson(String lessonId) async =>
      lessonCards[lessonId] ?? [];

  @override
  Future<List<Category>> getCategories() async => [];

  @override
  Future<List<Lesson>> getLessons(String categoryId) async => [];
}

class _FakeWeakItemRepository implements WeakItemRepository {
  List<String> cardIds = [];

  @override
  Future<void> addWeakItemManually(String cardId) async {}

  @override
  Future<WeakItem?> getByCardId(String cardId) async => null;

  @override
  Future<List<WeakItem>> getWeakItems() async {
    return cardIds
        .map(
          (id) => WeakItem(
            id: 'weak-$id',
            cardId: id,
            wrongCount: 1,
            correctCount: 0,
            sync: SyncMetadata(version: 1, updatedAt: DateTime.utc(2026, 7, 8)),
          ),
        )
        .toList();
  }

  @override
  Future<WeakItem> recordCorrectAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async =>
      throw UnimplementedError();

  @override
  Future<WeakItem> recordWrongAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async =>
      throw UnimplementedError();

  @override
  Future<void> removeWeakItem(String id) async {}
}

class _FakeDeckRepository implements DeckRepository {
  final deckCards = <String, List<DeckCard>>{};

  @override
  Future<void> addCardToDeck({
    required String deckId,
    required String cardId,
  }) async {}

  @override
  Future<Deck> createDeck({required String name, String? description}) async =>
      throw UnimplementedError();

  @override
  Future<void> deleteDeck(String id) async {}

  @override
  Future<Deck?> getDeckById(String id) async => null;

  @override
  Future<List<DeckCard>> getDeckCards(String deckId) async =>
      deckCards[deckId] ?? [];

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