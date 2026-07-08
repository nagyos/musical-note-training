import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';

/// Records study outcomes into weak-item storage.
class WeakItemRecorder {
  const WeakItemRecorder({required WeakItemRepository repository})
      : _repository = repository;

  final WeakItemRepository _repository;

  Future<void> onAnswer({
    required String cardId,
    required bool isCorrect,
    required DateTime answeredAt,
  }) async {
    if (isCorrect) {
      final existing = await _repository.getByCardId(cardId);
      if (existing == null) return;
      await _repository.recordCorrectAnswer(
        cardId: cardId,
        answeredAt: answeredAt,
      );
      return;
    }

    await _repository.recordWrongAnswer(
      cardId: cardId,
      answeredAt: answeredAt,
    );
  }
}