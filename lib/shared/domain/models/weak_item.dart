import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

/// Tracks cards the user struggles with.
class WeakItem {
  const WeakItem({
    required this.id,
    required this.cardId,
    required this.wrongCount,
    required this.correctCount,
    required this.sync,
    this.lastAnsweredAt,
  });

  final String id;
  final String cardId;
  final int wrongCount;
  final int correctCount;
  final DateTime? lastAnsweredAt;
  final SyncMetadata sync;

  double get accuracy {
    final total = wrongCount + correctCount;
    if (total == 0) return 0;
    return correctCount / total;
  }

  WeakItem recordAnswer({required bool isCorrect, required DateTime answeredAt}) {
    return WeakItem(
      id: id,
      cardId: cardId,
      wrongCount: isCorrect ? wrongCount : wrongCount + 1,
      correctCount: isCorrect ? correctCount + 1 : correctCount,
      lastAnsweredAt: answeredAt,
      sync: sync.copyWith(
        version: sync.version + 1,
        updatedAt: answeredAt,
      ),
    );
  }
}