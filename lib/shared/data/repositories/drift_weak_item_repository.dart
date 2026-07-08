import 'package:drift/drift.dart';

import 'package:musical_note_training/core/utils/id_generator.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart'
    hide WeakItem;
import 'package:musical_note_training/shared/data/mappers/weak_item_mapper.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';
import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';

class DriftWeakItemRepository implements WeakItemRepository {
  DriftWeakItemRepository({
    required this._database,
    IdGenerator? idGenerator,
  }) : _idGenerator = idGenerator ?? const TimestampIdGenerator();

  final AppDatabase _database;
  final IdGenerator _idGenerator;

  @override
  Future<List<WeakItem>> getWeakItems() async {
    final rows = await (_database.select(_database.weakItems)
          ..orderBy([
            (t) => OrderingTerm.desc(t.wrongCount),
            (t) => OrderingTerm.desc(t.updatedAt),
          ]))
        .get();
    return rows.map(WeakItemMapper.toDomain).toList();
  }

  @override
  Future<WeakItem?> getByCardId(String cardId) async {
    final row = await (_database.select(_database.weakItems)
          ..where((t) => t.cardId.equals(cardId)))
        .getSingleOrNull();
    return row == null ? null : WeakItemMapper.toDomain(row);
  }

  @override
  Future<WeakItem> recordWrongAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async {
    final existing = await getByCardId(cardId);
    if (existing != null) {
      final updated = existing.recordAnswer(
        isCorrect: false,
        answeredAt: answeredAt,
      );
      await _write(updated);
      return updated;
    }

    final now = answeredAt;
    final id = _idGenerator.next('weak');
    await _database.into(_database.weakItems).insert(
          WeakItemsCompanion.insert(
            id: id,
            cardId: cardId,
            wrongCount: const Value(1),
            correctCount: const Value(0),
            lastAnsweredAt: Value(now),
            updatedAt: now,
          ),
        );
    return (await getByCardId(cardId))!;
  }

  @override
  Future<WeakItem> recordCorrectAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async {
    final existing = await getByCardId(cardId);
    if (existing == null) {
      throw StateError('Weak item not found for card: $cardId');
    }
    final updated = existing.recordAnswer(
      isCorrect: true,
      answeredAt: answeredAt,
    );
    await _write(updated);
    return updated;
  }

  @override
  Future<void> removeWeakItem(String id) async {
    await (_database.delete(_database.weakItems)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  @override
  Future<void> addWeakItemManually(String cardId) async {
    final existing = await getByCardId(cardId);
    if (existing != null) return;

    final now = DateTime.now().toUtc();
    await _database.into(_database.weakItems).insert(
          WeakItemsCompanion.insert(
            id: _idGenerator.next('weak'),
            cardId: cardId,
            wrongCount: const Value(0),
            correctCount: const Value(0),
            updatedAt: now,
          ),
        );
  }

  Future<void> _write(WeakItem item) async {
    await (_database.update(_database.weakItems)
          ..where((t) => t.id.equals(item.id)))
        .write(
      WeakItemsCompanion(
        wrongCount: Value(item.wrongCount),
        correctCount: Value(item.correctCount),
        lastAnsweredAt: Value(item.lastAnsweredAt),
        version: Value(item.sync.version),
        updatedAt: Value(item.sync.updatedAt),
      ),
    );
  }
}