import 'dart:math';

import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';

/// Pure functions for study session transitions (unit-testable).
abstract final class StudySessionLogic {
  static const defaultChoiceCount = 4;

  static List<Card> shuffleCards(List<Card> cards, {Random? random}) {
    final copy = List<Card>.from(cards);
    copy.shuffle(random ?? Random());
    return copy;
  }

  static List<String> buildChoices({
    required Card current,
    required List<Card> pool,
    required String locale,
    int choiceCount = defaultChoiceCount,
    Random? random,
  }) {
    final correct = current.answer.resolve(locale);
    final distractors = pool
        .where((c) => c.id != current.id)
        .map((c) => c.answer.resolve(locale))
        .toSet()
        .toList();

    distractors.shuffle(random ?? Random());
    final choices = <String>[correct];
    for (final d in distractors) {
      if (choices.length >= choiceCount) break;
      if (!choices.contains(d)) choices.add(d);
    }

    choices.shuffle(random ?? Random());
    return choices;
  }

  static StudySessionState startSession({
    required List<Card> lessonCards,
    required String locale,
    Random? random,
  }) {
    final shuffled = shuffleCards(lessonCards, random: random);
    return StudySessionState(
      cards: shuffled,
      currentIndex: 0,
      phase: StudyPhase.questioning,
      choices: buildChoices(
        current: shuffled.first,
        pool: shuffled,
        locale: locale,
        random: random,
      ),
      locale: locale,
    );
  }

  static StudySessionState submitAnswer(
    StudySessionState state,
    String selected,
  ) {
    final correct = state.currentCard.answer.resolve(state.locale);
    return state.copyWith(
      phase: StudyPhase.feedback,
      selectedAnswer: selected,
      wasCorrect: selected == correct,
    );
  }

  static StudySessionState advance(StudySessionState state, {Random? random}) {
    if (state.phase != StudyPhase.feedback) return state;

    if (state.isLastCard) {
      return state.copyWith(phase: StudyPhase.completed);
    }

    final nextIndex = state.currentIndex + 1;
    final nextCard = state.cards[nextIndex];
    return StudySessionState(
      cards: state.cards,
      currentIndex: nextIndex,
      phase: StudyPhase.questioning,
      choices: buildChoices(
        current: nextCard,
        pool: state.cards,
        locale: state.locale,
        random: random,
      ),
      locale: state.locale,
    );
  }
}