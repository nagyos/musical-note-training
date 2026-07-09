import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_colors.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';
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
    ref.listen<StudySessionState?>(studySessionProvider, (previous, next) {
      if (next?.phase == StudyPhase.completed &&
          previous?.phase != StudyPhase.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleCompletion(next!);
        });
      }
    });

    final session = ref.watch(studySessionProvider);
    final l10n = context.l10n;

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
            ),
    );
  }
}

class _StudySessionView extends StatelessWidget {
  const _StudySessionView({
    required this.session,
    required this.onSelect,
  });

  final StudySessionState session;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final card = session.currentCard;
    final canAnswer = session.phase == StudyPhase.questioning;

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
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: StaffCanvas(payload: card.notation),
                  ),
                  if (session.isRevealingCorrect)
                    Positioned.fill(
                      child: ColoredBox(
                        color: AppColors.success.withValues(alpha: 0.08),
                        child: const Icon(
                          Icons.check_circle_outline,
                          size: 72,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.studyQuestionPrompt,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _ZigzagChoiceStrip(
            choices: session.choices,
            eliminatedChoices: session.eliminatedChoices,
            enabled: canAnswer,
            onSelect: onSelect,
          ),
        ],
      ),
    );
  }
}

class _ZigzagChoiceStrip extends StatelessWidget {
  const _ZigzagChoiceStrip({
    required this.choices,
    required this.eliminatedChoices,
    required this.enabled,
    required this.onSelect,
  });

  final List<String> choices;
  final Set<String> eliminatedChoices;
  final bool enabled;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final rowStep = AppSpacing.studyChoiceZigzagRowStep;

    return SizedBox(
      height: AppSpacing.studyChoiceButtonHeight + rowStep,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < choices.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs / 2),
                child: Transform.translate(
                  offset: Offset(
                    0,
                    StudyAnswerChoices.zigzagRows[i] * rowStep,
                  ),
                  child: _ChoiceButton(
                    label: choices[i],
                    enabled: enabled && !eliminatedChoices.contains(choices[i]),
                    isEliminated: eliminatedChoices.contains(choices[i]),
                    onPressed: () => onSelect(choices[i]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.label,
    required this.onPressed,
    required this.isEliminated,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isEliminated;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: AppSpacing.studyChoiceButtonHeight,
      child: FilledButton.tonal(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          side: isEliminated
              ? const BorderSide(color: AppColors.error, width: 2)
              : null,
          disabledBackgroundColor: isEliminated
              ? AppColors.error.withValues(alpha: 0.08)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          disabledForegroundColor: isEliminated
              ? colorScheme.onSurface.withValues(alpha: 0.45)
              : colorScheme.onSurface.withValues(alpha: 0.38),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}