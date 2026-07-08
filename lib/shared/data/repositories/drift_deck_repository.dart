import 'package:drift/drift.dart';

import 'package:musical_note_training/core/utils/id_generator.dart';
import 'package:musical_note_training/features/deck/domain/deck_validator.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart'
    hide Deck, DeckCard;
import 'package:musical_note_training/shared/data/mappers/deck_mapper.dart';
import 'package:musical_note_training/shared/domain/models/deck.dart';
import 'package:musical_note_training/shared/domain/models/deck_card.dart';
import 'package:musical_note_training/shared/domain/repositories/deck_repository.dart';

class DriftDeckRepository implements DeckRepository {
  DriftDeckRepository({
    required this._database,
    IdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? const TimestampIdGenerator();

  final AppDatabase _database;
  final IdGenerator _idGenerator;

  @override
  Future<List<Deck>> getDecks() async {
    final rows = await (_database.select(_database.decks)
          ..orderBy([
            (t) => OrderingTerm.desc(t.updatedAt),
          ]))
        .get();
    return rows.map(DeckMapper.toDomain).toList();
  }

  @override
  Future<Deck?> getDeckById(String id) async {
    final row = await (_database.select(_database.decks)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : DeckMapper.toDomain(row);
  }

  @override
  Future<Deck> createDeck({required String name, String? description}) async {
    final validName = DeckValidator.validateName(name);
    final now = DateTime.now().toUtc();
    final id = _idGenerator.next('deck');

    await _database.into(_database.decks).insert(
          DecksCompanion.insert(
            id: id,
            name: validName,
            description: Value(description),
            createdAt: now,
            updatedAt: now,
          ),
        );

    return (await getDeckById(id))!;
  }

  @override
  Future<Deck> updateDeck(Deck deck) async {
    final validName = DeckValidator.validateName(deck.name);
    final now = DateTime.now().toUtc();
    final nextVersion = deck.sync.version + 1;

    await (_database.update(_database.decks)..where((t) => t.id.equals(deck.id)))
        .write(
      DecksCompanion(
        name: Value(validName),
        description: Value(deck.description),
        version: Value(nextVersion),
        updatedAt: Value(now),
      ),
    );

    return (await getDeckById(deck.id))!;
  }

  @override
  Future<void> deleteDeck(String id) async {
    await (_database.delete(_database.deckCards)
          ..where((t) => t.deckId.equals(id)))
        .go();
    await (_database.delete(_database.decks)..where((t) => t.id.equals(id)))
        .go();
  }

  @override
  Future<List<DeckCard>> getDeckCards(String deckId) async {
    final rows = await (_database.select(_database.deckCards)
          ..where((t) => t.deckId.equals(deckId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
    return rows.map(DeckMapper.toDeckCardDomain).toList();
  }

  @override
  Future<void> addCardToDeck({
    required String deckId,
    required String cardId,
  }) async {
    final existing = await (_database.select(_database.deckCards)
          ..where(
            (t) => t.deckId.equals(deckId) & t.cardId.equals(cardId),
          ))
        .getSingleOrNull();
    if (existing != null) return;

    final nextOrder = (await getDeckCards(deckId)).length;

    await _database.into(_database.deckCards).insert(
          DeckCardsCompanion.insert(
            deckId: deckId,
            cardId: cardId,
            sortOrder: nextOrder,
            addedAt: DateTime.now().toUtc(),
          ),
        );

    await _touchDeck(deckId);
  }

  @override
  Future<void> removeCardFromDeck({
    required String deckId,
    required String cardId,
  }) async {
    await (_database.delete(_database.deckCards)
          ..where(
            (t) => t.deckId.equals(deckId) & t.cardId.equals(cardId),
          ))
        .go();
    await _touchDeck(deckId);
  }

  Future<void> _touchDeck(String deckId) async {
    final deck = await getDeckById(deckId);
    if (deck == null) return;
    await updateDeck(deck);
  }
}