import 'package:musical_note_training/shared/domain/models/weak_item.dart';
import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';

/// Placeholder until weak-items feature lands (issue/5).
class EmptyWeakItemRepository implements WeakItemRepository {
  const EmptyWeakItemRepository();

  @override
  Future<void> addWeakItemManually(String cardId) async {}

  @override
  Future<WeakItem?> getByCardId(String cardId) async => null;

  @override
  Future<List<WeakItem>> getWeakItems() async => [];

  @override
  Future<WeakItem> recordCorrectAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async {
    throw UnsupportedError('WeakItemRepository is not available yet');
  }

  @override
  Future<WeakItem> recordWrongAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async {
    throw UnsupportedError('WeakItemRepository is not available yet');
  }

  @override
  Future<void> removeWeakItem(String id) async {}
}