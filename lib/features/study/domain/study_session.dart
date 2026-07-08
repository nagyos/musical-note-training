import 'package:musical_note_training/shared/domain/models/card.dart';

enum StudyPhase {
  questioning,
  feedback,
  completed,
}

/// In-memory state for a single catalog lesson quiz run.
class StudySessionState {
  const StudySessionState({
    required this.cards,
    required this.currentIndex,
    required this.phase,
    required this.choices,
    required this.locale,
    this.wasCorrect,
    this.selectedAnswer,
  });

  final List<Card> cards;
  final int currentIndex;
  final StudyPhase phase;
  final List<String> choices;
  final String locale;
  final bool? wasCorrect;
  final String? selectedAnswer;

  Card get currentCard => cards[currentIndex];

  int get total => cards.length;

  int get answeredCount => phase == StudyPhase.questioning ? currentIndex : currentIndex + 1;

  bool get isLastCard => currentIndex >= cards.length - 1;

  StudySessionState copyWith({
    List<Card>? cards,
    int? currentIndex,
    StudyPhase? phase,
    List<String>? choices,
    String? locale,
    bool? wasCorrect,
    String? selectedAnswer,
    bool clearSelectedAnswer = false,
    bool clearWasCorrect = false,
  }) {
    return StudySessionState(
      cards: cards ?? this.cards,
      currentIndex: currentIndex ?? this.currentIndex,
      phase: phase ?? this.phase,
      choices: choices ?? this.choices,
      locale: locale ?? this.locale,
      wasCorrect: clearWasCorrect ? null : (wasCorrect ?? this.wasCorrect),
      selectedAnswer:
          clearSelectedAnswer ? null : (selectedAnswer ?? this.selectedAnswer),
    );
  }
}