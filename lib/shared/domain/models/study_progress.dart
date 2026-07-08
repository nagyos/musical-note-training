import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

/// Completion state for a lesson or category.
class StudyProgress {
  const StudyProgress({
    required this.id,
    required this.lessonId,
    required this.completedCardIds,
    required this.sync,
  });

  final String id;
  final String lessonId;
  final Set<String> completedCardIds;
  final SyncMetadata sync;

  double completionRate(int totalCards) {
    if (totalCards <= 0) return 0;
    return completedCardIds.length / totalCards;
  }
}