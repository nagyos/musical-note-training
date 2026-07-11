import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';

enum StudyPhase {
  questioning,
  revealingCorrect,
  completed,
}

/// A card answered incorrectly during the current session (first wrong pick only).
class StudyMistake {
  const StudyMistake({
    required this.card,
    required this.selectedAnswer,
  });

  final Card card;
  final String selectedAnswer;
}

/// Delay before auto-advancing after a correct answer.
abstract final class StudySessionTiming {
  static const Duration correctRevealDuration = Duration(milliseconds: 700);
}

/// In-memory state for a single catalog lesson quiz run.
class StudySessionState {
  const StudySessionState({
    required this.cards,
    required this.currentIndex,
    required this.phase,
    required this.choices,
    required this.noteAnswerLocale,
    required this.uiLocale,
    this.correctCount = 0,
    this.mistakes = const [],
    this.eliminatedChoices = const {},
  });

  final List<Card> cards;
  final int currentIndex;
  final StudyPhase phase;
  final List<String> choices;
  final String noteAnswerLocale;
  final String uiLocale;
  final int correctCount;
  final List<StudyMistake> mistakes;

  /// Wrong answers picked for the current card; buttons stay disabled.
  final Set<String> eliminatedChoices;

  Card get currentCard => cards[currentIndex];

  int get total => cards.length;

  int get answeredCount => currentIndex + (phase == StudyPhase.questioning ? 0 : 1);

  bool get isLastCard => currentIndex >= cards.length - 1;

  bool get isRevealingCorrect => phase == StudyPhase.revealingCorrect;

  String localeFor(Card card) => StudyAnswerChoices.localeForCategory(
        category: card.categoryType,
        noteAnswerLocale: noteAnswerLocale,
        uiLocale: uiLocale,
      );

  String get currentLocale => localeFor(currentCard);

  StudySessionState copyWith({
    List<Card>? cards,
    int? currentIndex,
    StudyPhase? phase,
    List<String>? choices,
    String? noteAnswerLocale,
    String? uiLocale,
    int? correctCount,
    List<StudyMistake>? mistakes,
    Set<String>? eliminatedChoices,
  }) {
    return StudySessionState(
      cards: cards ?? this.cards,
      currentIndex: currentIndex ?? this.currentIndex,
      phase: phase ?? this.phase,
      choices: choices ?? this.choices,
      noteAnswerLocale: noteAnswerLocale ?? this.noteAnswerLocale,
      uiLocale: uiLocale ?? this.uiLocale,
      correctCount: correctCount ?? this.correctCount,
      mistakes: mistakes ?? this.mistakes,
      eliminatedChoices: eliminatedChoices ?? this.eliminatedChoices,
    );
  }
}