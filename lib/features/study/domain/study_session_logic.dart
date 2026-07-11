import 'dart:math';

import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';
import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';

/// Pure functions for study session transitions (unit-testable).
abstract final class StudySessionLogic {
  static List<Card> shuffleCards(List<Card> cards, {Random? random}) {
    final copy = List<Card>.from(cards);
    copy.shuffle(random ?? Random());
    return copy;
  }

  static List<String> buildChoices({
    required CardCategoryType category,
    required String noteAnswerLocale,
    required String uiLocale,
  }) {
    final locale = StudyAnswerChoices.localeForCategory(
      category: category,
      noteAnswerLocale: noteAnswerLocale,
      uiLocale: uiLocale,
    );
    return StudyAnswerChoices.forCategory(category, locale);
  }

  static StudySessionState startSession({
    required List<Card> lessonCards,
    required String noteAnswerLocale,
    required String uiLocale,
    Random? random,
  }) {
    final shuffled = shuffleCards(lessonCards, random: random);
    return StudySessionState(
      cards: shuffled,
      currentIndex: 0,
      phase: StudyPhase.questioning,
      choices: buildChoices(
        category: shuffled.first.categoryType,
        noteAnswerLocale: noteAnswerLocale,
        uiLocale: uiLocale,
      ),
      noteAnswerLocale: noteAnswerLocale,
      uiLocale: uiLocale,
    );
  }

  static StudySessionState submitAnswer(
    StudySessionState state,
    String selected,
  ) {
    if (state.phase != StudyPhase.questioning) return state;
    if (state.eliminatedChoices.contains(selected)) return state;

    final correct =
        state.currentCard.answer.resolve(state.currentLocale);
    if (selected == correct) {
      return state.copyWith(
        phase: StudyPhase.revealingCorrect,
        correctCount: state.correctCount + 1,
      );
    }

    final alreadyMistaken = state.mistakes.any(
      (m) => m.card.id == state.currentCard.id,
    );
    final mistakes = alreadyMistaken
        ? state.mistakes
        : [
            ...state.mistakes,
            StudyMistake(
              card: state.currentCard,
              selectedAnswer: selected,
            ),
          ];

    return state.copyWith(
      eliminatedChoices: {...state.eliminatedChoices, selected},
      mistakes: mistakes,
    );
  }

  static StudySessionState advanceAfterCorrect(
    StudySessionState state, {
    Random? random,
  }) {
    if (state.phase != StudyPhase.revealingCorrect) return state;

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
        category: nextCard.categoryType,
        noteAnswerLocale: state.noteAnswerLocale,
        uiLocale: state.uiLocale,
      ),
      noteAnswerLocale: state.noteAnswerLocale,
      uiLocale: state.uiLocale,
      correctCount: state.correctCount,
      mistakes: state.mistakes,
    );
  }
}