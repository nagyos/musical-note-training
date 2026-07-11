import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';
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

    final settings = ref.read(appSettingsProvider);
    state = StudySessionLogic.startSession(
      lessonCards: cards,
      noteAnswerLocale: settings.answerLocaleKey,
      uiLocale: settings.uiLocaleCode,
    );
  }

  void submitAnswer(String choice) {
    final current = state;
    if (current == null || current.phase != StudyPhase.questioning) return;
    if (current.eliminatedChoices.contains(choice)) return;

    final next = StudySessionLogic.submitAnswer(current, choice);
    state = next;

    if (next.phase == StudyPhase.revealingCorrect) {
      _recordAnswer(cardId: next.currentCard.id, isCorrect: true);
      Future.delayed(StudySessionTiming.correctRevealDuration, () {
        final currentState = state;
        if (currentState?.phase != StudyPhase.revealingCorrect) return;
        state = StudySessionLogic.advanceAfterCorrect(currentState!);
      });
    } else {
      _recordAnswer(cardId: next.currentCard.id, isCorrect: false);
    }
  }

  void _recordAnswer({required String cardId, required bool isCorrect}) {
    ref.read(weakItemRecorderProvider).onAnswer(
          cardId: cardId,
          isCorrect: isCorrect,
          answeredAt: DateTime.now().toUtc(),
        );
  }

  void reset() => state = null;
}