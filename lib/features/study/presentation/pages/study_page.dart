import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_colors.dart';
import 'package:musical_note_training/core/extensions/localized_text_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/study/domain/study_session.dart';
import 'package:musical_note_training/features/study/presentation/view_models/study_session_notifier.dart';
import 'package:musical_note_training/features/study/presentation/widgets/study_completion_dialog.dart';
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
  var _completionDialogShown = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_startSession);
  }

  Future<void> _startSession() async {
    _completionDialogShown = false;
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

  Future<void> _handleCompletion(StudySessionState session) async {
    if (_completionDialogShown || !mounted) return;
    _completionDialogShown = true;

    final action = await showStudyCompletionDialog(context, session: session);
    if (!mounted) return;

    switch (action) {
      case StudyCompletionAction.retry:
        await _startSession();
      case StudyCompletionAction.back:
      case null:
        context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    ref.listen<StudySessionState?>(studySessionProvider, (previous, next) {
      if (next?.phase == StudyPhase.completed &&
          previous?.phase != StudyPhase.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleCompletion(next!);
        });
      }
    });

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
          : _StudySessionView(
              session: session,
              onSelect: ref.read(studySessionProvider.notifier).submitAnswer,
              onContinue: ref.read(studySessionProvider.notifier).continueSession,
            ),
    );
  }
}

class _StudySessionView extends StatelessWidget {
  const _StudySessionView({
    required this.session,
    required this.onSelect,
    required this.onContinue,
  });

  final StudySessionState session;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final card = session.currentCard;
    final isFeedback = session.isFeedback;
    final correctAnswer = card.answer.resolve(session.locale);
    final wasCorrect = session.wasCorrect ?? false;
    final selected = session.selectedAnswer;

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
          if (card.notation != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: StaffCanvas(payload: card.notation),
              ),
            ),
          const SizedBox(height: AppSpacing.xl),
          if (isFeedback)
            _FeedbackHeader(
              wasCorrect: wasCorrect,
              correctAnswer: correctAnswer,
              hint: wasCorrect ? null : card.hint?.resolveFrom(context),
            )
          else
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
                return _ChoiceButton(
                  label: choice,
                  enabled: !isFeedback,
                  highlight: _choiceHighlight(
                    choice: choice,
                    isFeedback: isFeedback,
                    correctAnswer: correctAnswer,
                    selected: selected,
                    wasCorrect: wasCorrect,
                  ),
                  onPressed: isFeedback ? null : () => onSelect(choice),
                );
              },
            ),
          ),
          if (isFeedback) ...[
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: onContinue,
              child: Text(
                session.isLastCard ? l10n.studySeeResults : l10n.studyNext,
              ),
            ),
          ],
        ],
      ),
    );
  }

  _ChoiceHighlight? _choiceHighlight({
    required String choice,
    required bool isFeedback,
    required String correctAnswer,
    required String? selected,
    required bool wasCorrect,
  }) {
    if (!isFeedback) return null;
    if (choice == correctAnswer) return _ChoiceHighlight.correct;
    if (!wasCorrect && choice == selected) return _ChoiceHighlight.incorrect;
    return null;
  }
}

enum _ChoiceHighlight { correct, incorrect }

class _FeedbackHeader extends StatelessWidget {
  const _FeedbackHeader({
    required this.wasCorrect,
    required this.correctAnswer,
    this.hint,
  });

  final bool wasCorrect;
  final String correctAnswer;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Icon(
          wasCorrect ? Icons.check_circle_outline : Icons.highlight_off,
          color: wasCorrect ? AppColors.success : AppColors.error,
          size: 36,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          wasCorrect ? l10n.answerCorrect : l10n.answerIncorrect,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        if (!wasCorrect) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.correctAnswerLabel(correctAnswer),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (hint != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              hint!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ],
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.label,
    required this.onPressed,
    required this.highlight,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final _ChoiceHighlight? highlight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = switch (highlight) {
      _ChoiceHighlight.correct => AppColors.success,
      _ChoiceHighlight.incorrect => AppColors.error,
      null => null,
    };

    return SizedBox(
      height: AppSpacing.studyChoiceButtonHeight,
      child: FilledButton.tonal(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          side: borderColor == null
              ? null
              : BorderSide(color: borderColor, width: 2),
          backgroundColor: switch (highlight) {
            _ChoiceHighlight.correct =>
              AppColors.success.withValues(alpha: 0.12),
            _ChoiceHighlight.incorrect =>
              AppColors.error.withValues(alpha: 0.12),
            null => null,
          },
          disabledBackgroundColor: switch (highlight) {
            _ChoiceHighlight.correct =>
              AppColors.success.withValues(alpha: 0.12),
            _ChoiceHighlight.incorrect =>
              AppColors.error.withValues(alpha: 0.12),
            null => colorScheme.surfaceContainerHighest,
          },
          disabledForegroundColor: colorScheme.onSurface,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}