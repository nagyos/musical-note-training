import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/extensions/localized_text_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/features/study/presentation/view_models/study_session_notifier.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_canvas.dart';

enum StudySource { lesson, deck, weakItems }

class StudyPage extends ConsumerStatefulWidget {
  const StudyPage({
    super.key,
    this.lessonId,
    this.deckId,
    this.source = StudySource.lesson,
  });

  final String? lessonId;
  final String? deckId;
  final StudySource source;

  @override
  ConsumerState<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends ConsumerState<StudyPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_startSession);
  }

  Future<void> _startSession() async {
    final notifier = ref.read(studySessionProvider.notifier);
    switch (widget.source) {
      case StudySource.lesson:
        if (widget.lessonId != null) {
          await notifier.startLesson(widget.lessonId!);
        }
      case StudySource.deck:
        if (widget.deckId != null) {
          await notifier.startDeck(widget.deckId!);
        }
      case StudySource.weakItems:
        await notifier.startWeakItems();
    }
  }

  @override
  void dispose() {
    ref.read(studySessionProvider.notifier).reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = ref.watch(studySessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.studyTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: session == null
          ? const Center(child: CircularProgressIndicator())
          : _StudyBody(session: session),
    );
  }
}

class _StudyBody extends ConsumerWidget {
  const _StudyBody({required this.session});

  final StudySessionState session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(studySessionProvider.notifier);

    return switch (session.phase) {
      StudyPhase.completed => _CompletedView(total: session.total),
      StudyPhase.feedback => _FeedbackView(
          session: session,
          onContinue: notifier.continueSession,
        ),
      StudyPhase.questioning => _QuestionView(
          session: session,
          onSelect: notifier.submitAnswer,
        ),
    };
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({required this.session, required this.onSelect});

  final StudySessionState session;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final card = session.currentCard;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.studyProgress(session.currentIndex + 1, session.total),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          if (card.notation != null) StaffCanvas(payload: card.notation),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.studyQuestionPrompt,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: session.choices.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final choice = session.choices[index];
                return FilledButton.tonal(
                  onPressed: () => onSelect(choice),
                  child: Text(choice),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackView extends StatelessWidget {
  const _FeedbackView({required this.session, required this.onContinue});

  final StudySessionState session;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final card = session.currentCard;
    final correct = card.answer.resolve(session.locale);
    final isCorrect = session.wasCorrect ?? false;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isCorrect ? l10n.answerCorrect : l10n.answerIncorrect,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.correctAnswerLabel(correct),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (!isCorrect && card.hint != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              card.hint!.resolveFrom(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const Spacer(),
          FilledButton(
            onPressed: onContinue,
            child: Text(
              session.isLastCard ? l10n.studySeeResults : l10n.studyNext,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedView extends StatelessWidget {
  const _CompletedView({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.emoji_events, size: 56),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.studySessionComplete,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.studyQuestionsFinished(total),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: () => context.pop(),
            child: Text(l10n.back),
          ),
        ],
      ),
    );
  }
}