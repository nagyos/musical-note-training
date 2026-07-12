import 'package:flutter/material.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';

Future<void> showBackupHelpDialog(BuildContext context) {
  final l10n = context.l10n;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.backupHelpTitle),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.backupHelpGoogleSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.backupHelpGoogleBody),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.backupHelpExportSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.backupHelpExportBody),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.backupHelpImportSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.backupHelpImportBody),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.backupHelpClose),
        ),
      ],
    ),
  );
}