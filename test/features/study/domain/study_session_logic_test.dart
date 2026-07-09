import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/features/study/domain/study_session_logic.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/localized_text.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

void main() {
  final cards = [
    _card('note-c4', 'ド'),
    _card('note-d4', 'レ'),
    _card('note-e4', 'ミ'),
  ];

  group('StudySessionLogic', () {
    test('startSession shuffles and builds choices', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        locale: 'ja',
        random: Random(1),
      );

      expect(session.phase, StudyPhase.questioning);
      expect(session.cards, hasLength(3));
      expect(session.choices, contains(session.currentCard.answer.resolve('ja')));
    });

    test('submitAnswer marks correct response', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        locale: 'ja',
        random: Random(0),
      );
      final correct = session.currentCard.answer.resolve('ja');
      final answered = StudySessionLogic.submitAnswer(session, correct);

      expect(answered.phase, StudyPhase.feedback);
      expect(answered.wasCorrect, isTrue);
      expect(answered.correctCount, 1);
      expect(answered.mistakes, isEmpty);
    });

    test('submitAnswer records mistakes', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        locale: 'ja',
        random: Random(0),
      );
      final answered = StudySessionLogic.submitAnswer(session, 'wrong');

      expect(answered.wasCorrect, isFalse);
      expect(answered.correctCount, 0);
      expect(answered.mistakes, hasLength(1));
      expect(answered.mistakes.first.selectedAnswer, 'wrong');
    });

    test('advance moves to next question', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        locale: 'ja',
        random: Random(0),
      );
      final correct = session.currentCard.answer.resolve('ja');
      final feedback = StudySessionLogic.submitAnswer(session, correct);
      final next = StudySessionLogic.advance(feedback, random: Random(0));

      expect(next.phase, StudyPhase.questioning);
      expect(next.currentIndex, 1);
    });
  });
}

Card _card(String id, String jaAnswer) {
  final now = DateTime.utc(2026, 7, 8);
  return Card(
    id: id,
    categoryType: CardCategoryType.note,
    lessonId: 'note-middle-c',
    answer: LocalizedText(values: {'ja': jaAnswer, 'en': jaAnswer}),
    sortOrder: 0,
    sync: SyncMetadata(version: 1, updatedAt: now),
  );
}