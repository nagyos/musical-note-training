import 'package:musical_note_training/shared/domain/models/weak_item.dart';

abstract class WeakItemRepository {
  Future<List<WeakItem>> getWeakItems();

  Future<WeakItem?> getByCardId(String cardId);

  Future<WeakItem> recordWrongAnswer({
    required String cardId,
    required DateTime answeredAt,
  });

  Future<WeakItem> recordCorrectAnswer({
    required String cardId,
    required DateTime answeredAt,
  });

  Future<void> removeWeakItem(String id);

  Future<void> addWeakItemManually(String cardId);
}