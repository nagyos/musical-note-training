import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/features/study/domain/study_launch_target.dart';
import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/features/study/domain/study_session_logic.dart';

final studySessionProvider =
    NotifierProvider<StudySessionNotifier, StudySessionState?>(
  StudySessionNotifier.new,
);

class StudySessionNotifier extends Notifier<StudySessionState?> {
  @override
  StudySessionState? build() => null;

  Future<void> startLesson(String lessonId) =>
      _start(LessonLaunchTarget(lessonId));

  Future<void> startDeck(String deckId) => _start(DeckLaunchTarget(deckId));

  Future<void> startWeakItems() => _start(const WeakItemsLaunchTarget());

  Future<void> _start(StudyLaunchTarget target) async {
    final cards = await ref.read(studyLaunchServiceProvider).loadCards(target);
    if (cards.isEmpty) return;

    final locale = ref.read(appLocaleProvider);
    state = StudySessionLogic.startSession(lessonCards: cards, locale: locale);
  }

  void submitAnswer(String choice) {
    final current = state;
    if (current == null || current.phase != StudyPhase.questioning) return;

    state = StudySessionLogic.submitAnswer(current, choice);
  }

  void continueSession() {
    final current = state;
    if (current == null || current.phase != StudyPhase.feedback) return;
    state = StudySessionLogic.advance(current);
  }

  void reset() => state = null;
}