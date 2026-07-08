import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/core/utils/id_generator.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart';
import 'package:musical_note_training/shared/data/repositories/drift_deck_repository.dart';

void main() {
  late AppDatabase database;
  late DriftDeckRepository repository;

  setUp(() {
    database = AppDatabase.inMemory();
    repository = DriftDeckRepository(
      database: database,
      idGenerator: SequentialIdGenerator('deck'),
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('DriftDeckRepository', () {
    test('createDeck persists and returns deck', () async {
      final deck = await repository.createDeck(name: '  復習  ', description: 'memo');

      expect(deck.name, '復習');
      expect(deck.description, 'memo');

      final decks = await repository.getDecks();
      expect(decks, hasLength(1));
      expect(decks.first.id, deck.id);
    });

    test('updateDeck changes name and bumps version', () async {
      final deck = await repository.createDeck(name: 'A');
      final updated = await repository.updateDeck(deck.copyWith(name: 'B'));

      expect(updated.name, 'B');
      expect(updated.sync.version, greaterThan(deck.sync.version));
    });

    test('deleteDeck removes deck and deck cards', () async {
      final deck = await repository.createDeck(name: 'Delete me');
      await repository.addCardToDeck(deckId: deck.id, cardId: 'note-c4');
      await repository.deleteDeck(deck.id);

      expect(await repository.getDeckById(deck.id), isNull);
      expect(await repository.getDeckCards(deck.id), isEmpty);
    });

    test('addCardToDeck is idempotent per card', () async {
      final deck = await repository.createDeck(name: 'Deck');
      await repository.addCardToDeck(deckId: deck.id, cardId: 'note-c4');
      await repository.addCardToDeck(deckId: deck.id, cardId: 'note-c4');

      final cards = await repository.getDeckCards(deck.id);
      expect(cards, hasLength(1));
    });

    test('removeCardFromDeck deletes association', () async {
      final deck = await repository.createDeck(name: 'Deck');
      await repository.addCardToDeck(deckId: deck.id, cardId: 'note-c4');
      await repository.removeCardFromDeck(deckId: deck.id, cardId: 'note-c4');

      expect(await repository.getDeckCards(deck.id), isEmpty);
    });
  });
}