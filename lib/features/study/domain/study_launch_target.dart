sealed class StudyLaunchTarget {
  const StudyLaunchTarget();
}

final class LessonLaunchTarget extends StudyLaunchTarget {
  const LessonLaunchTarget(this.lessonId);

  final String lessonId;
}

final class DeckLaunchTarget extends StudyLaunchTarget {
  const DeckLaunchTarget(this.deckId);

  final String deckId;
}

final class WeakItemsLaunchTarget extends StudyLaunchTarget {
  const WeakItemsLaunchTarget();
}