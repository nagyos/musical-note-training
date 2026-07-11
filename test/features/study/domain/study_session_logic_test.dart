import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';
import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/features/study/domain/study_session_logic.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';
import 'package:musical_note_training/shared/domain/models/localized_text.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

void main() {
  final cards = [
    _card('note-c4', 'ド', enAnswer: 'C'),
    _card('note-d4', 'レ', enAnswer: 'D'),
    _card('note-e4', 'ミ', enAnswer: 'E'),
  ];

  group('StudySessionLogic', () {
    test('startSession shuffles cards and exposes fixed seven solfege choices', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
        random: Random(1),
      );

      expect(session.phase, StudyPhase.questioning);
      expect(session.cards, hasLength(3));
      expect(
        session.choices,
        ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'],
      );
      expect(
        session.choices,
        contains(session.currentCard.answer.resolve('ja')),
      );
    });

    test('startSession uses letter names when note style is en', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'en',
        uiLocale: 'ja',
      );

      expect(session.choices, StudyAnswerChoices.letters);
    });

    test('submitAnswer reveals correct without advancing immediately', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
        random: Random(0),
      );
      final correct = session.currentCard.answer.resolve('ja');
      final answered = StudySessionLogic.submitAnswer(session, correct);

      expect(answered.phase, StudyPhase.revealingCorrect);
      expect(answered.correctCount, 1);
      expect(answered.currentIndex, session.currentIndex);
    });

    test('submitAnswer eliminates wrong choices and stays on card', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
        random: Random(0),
      );
      final wrong = session.choices.firstWhere(
        (c) => c != session.currentCard.answer.resolve('ja'),
      );
      final answered = StudySessionLogic.submitAnswer(session, wrong);

      expect(answered.phase, StudyPhase.questioning);
      expect(answered.eliminatedChoices, contains(wrong));
      expect(answered.mistakes, hasLength(1));
    });

    test('submitAnswer records only the first mistake per card', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
        random: Random(0),
      );
      final correct = session.currentCard.answer.resolve('ja');
      final wrongChoices = session.choices.where((c) => c != correct).toList();

      final afterFirst =
          StudySessionLogic.submitAnswer(session, wrongChoices.first);
      final afterSecond =
          StudySessionLogic.submitAnswer(afterFirst, wrongChoices[1]);

      expect(afterSecond.mistakes, hasLength(1));
      expect(afterSecond.eliminatedChoices, hasLength(2));
    });

    test('submitAnswer ignores eliminated choices', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
        random: Random(0),
      );
      final correct = session.currentCard.answer.resolve('ja');
      final wrong = session.choices.firstWhere((c) => c != correct);
      final afterWrong = StudySessionLogic.submitAnswer(session, wrong);
      final retap = StudySessionLogic.submitAnswer(afterWrong, wrong);

      expect(retap.eliminatedChoices, afterWrong.eliminatedChoices);
      expect(retap.mistakes, afterWrong.mistakes);
    });

    test('advanceAfterCorrect moves to next question', () {
      final session = StudySessionLogic.startSession(
        lessonCards: cards,
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
        random: Random(0),
      );
      final correct = session.currentCard.answer.resolve('ja');
      final revealed = StudySessionLogic.submitAnswer(session, correct);
      final next = StudySessionLogic.advanceAfterCorrect(revealed, random: Random(0));

      expect(next.phase, StudyPhase.questioning);
      expect(next.currentIndex, 1);
      expect(next.eliminatedChoices, isEmpty);
    });

    test('rest choices follow ui locale even when note style is letter', () {
      final restCards = [
        _card(
          'rest-whole',
          '全休符',
          enAnswer: 'Whole rest',
          categoryType: CardCategoryType.rest,
        ),
        _card(
          'rest-half',
          '二分休符',
          enAnswer: 'Half rest',
          categoryType: CardCategoryType.rest,
        ),
      ];
      final session = StudySessionLogic.startSession(
        lessonCards: restCards,
        noteAnswerLocale: 'en',
        uiLocale: 'ja',
      );

      expect(session.choices, StudyAnswerChoices.restsJa);
    });

    test('rest correct answer resolves with ui locale', () {
      final restCard = _card(
        'rest-whole',
        '全休符',
        enAnswer: 'Whole rest',
        categoryType: CardCategoryType.rest,
      );
      final session = StudySessionLogic.startSession(
        lessonCards: [restCard],
        noteAnswerLocale: 'en',
        uiLocale: 'ja',
      );

      final answered = StudySessionLogic.submitAnswer(session, '全休符');
      expect(answered.phase, StudyPhase.revealingCorrect);
    });

    test('advanceAfterCorrect completes session on last card', () {
      final session = StudySessionLogic.startSession(
        lessonCards: [cards.first],
        noteAnswerLocale: 'ja',
        uiLocale: 'ja',
      );
      final correct = session.currentCard.answer.resolve('ja');
      final revealed = StudySessionLogic.submitAnswer(session, correct);
      final done = StudySessionLogic.advanceAfterCorrect(revealed);

      expect(done.phase, StudyPhase.completed);
    });
  });
}

Card _card(
  String id,
  String jaAnswer, {
  String? enAnswer,
  CardCategoryType categoryType = CardCategoryType.note,
}) {
  final now = DateTime.utc(2026, 7, 8);
  return Card(
    id: id,
    categoryType: categoryType,
    lessonId: 'note-middle-c',
    answer: LocalizedText(
      values: {'ja': jaAnswer, 'en': enAnswer ?? jaAnswer},
    ),
    sortOrder: 0,
    sync: SyncMetadata(version: 1, updatedAt: now),
  );
}