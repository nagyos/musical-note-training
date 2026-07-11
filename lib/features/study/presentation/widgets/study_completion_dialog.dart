import 'package:flutter/material.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/study/domain/study_session.dart';

enum StudyCompletionAction { back, retry }

Future<StudyCompletionAction?> showStudyCompletionDialog(
  BuildContext context, {
  required StudySessionState session,
}) {
  final l10n = context.l10n;

  return showDialog<StudyCompletionAction>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.studySessionComplete),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.studyResultScore(session.correctCount, session.total),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (session.mistakes.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.studyWrongAnswersTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final mistake in session.mistakes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text(
                      l10n.studyWrongAnswerLine(
                        mistake.selectedAnswer,
                        mistake.card.answer.resolve(
                          session.localeFor(mistake.card),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, StudyCompletionAction.retry),
            child: Text(l10n.studyRetry),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, StudyCompletionAction.back),
            child: Text(l10n.back),
          ),
        ],
      );
    },
  );
}