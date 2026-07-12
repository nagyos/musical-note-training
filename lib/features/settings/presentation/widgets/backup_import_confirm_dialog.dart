import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/settings/domain/backup_import_preview.dart';
import 'package:musical_note_training/features/settings/domain/note_name_style.dart';
import 'package:musical_note_training/l10n/app_localizations.dart';

Future<bool> showBackupImportConfirmDialog(
  BuildContext context, {
  required BackupImportPreview preview,
  required String localeCode,
}) async {
  final l10n = context.l10n;
  final exportedAtLabel = DateFormat.yMMMd(localeCode).add_Hm().format(
        preview.remote.exportedAt.toLocal(),
      );

  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(l10n.backupImportConfirmTitle)),
          IconButton(
            autofocus: true,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            tooltip: l10n.cancel,
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.backupImportConfirmScopeTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.backupImportConfirmScopeBody,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.backupImportConfirmWarning,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.backupImportConfirmCountHeader,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            _CountChangeRow(
              label: l10n.backupImportConfirmCountDecks,
              current: preview.localDeckCount,
              after: preview.remoteDeckCount,
              delta: preview.deckDelta,
            ),
            _CountChangeRow(
              label: l10n.backupImportConfirmCountWeak,
              current: preview.localWeakCount,
              after: preview.remoteWeakCount,
              delta: preview.weakDelta,
            ),
            _CountChangeRow(
              label: l10n.backupImportConfirmCountProgress,
              current: preview.localProgressCount,
              after: preview.remoteProgressCount,
              delta: preview.progressDelta,
            ),
            if (preview.settingsChange) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.backupImportConfirmSettingsTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              if (preview.uiLocaleChanges)
                Text(
                  l10n.backupImportConfirmSettingsLocale(
                    _localeLabel(l10n, preview.local.settings.uiLocaleCode),
                    _localeLabel(l10n, preview.remote.settings.uiLocaleCode),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (preview.noteNameStyleChanges)
                Text(
                  l10n.backupImportConfirmSettingsNoteNames(
                    _noteNameLabel(l10n, preview.local.settings.noteNameStyle),
                    _noteNameLabel(l10n, preview.remote.settings.noteNameStyle),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.backupImportConfirmExportedAt(exportedAtLabel),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.backupImportConfirmApply),
        ),
      ],
    ),
  );

  return confirmed ?? false;
}

String _localeLabel(AppLocalizations l10n, String code) {
  return switch (code) {
    'en' => l10n.settingsLanguageEn,
    _ => l10n.settingsLanguageJa,
  };
}

String _noteNameLabel(AppLocalizations l10n, String storageValue) {
  final style = NoteNameStyle.fromStorage(storageValue);
  return style == NoteNameStyle.letter
      ? l10n.settingsNoteNamesLetter
      : l10n.settingsNoteNamesSolfege;
}

class _CountChangeRow extends StatelessWidget {
  const _CountChangeRow({
    required this.label,
    required this.current,
    required this.after,
    required this.delta,
  });

  final String label;
  final int current;
  final int after;
  final int delta;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final Color deltaColor;
    final String deltaLabel;
    if (delta > 0) {
      deltaColor = Colors.green.shade700;
      deltaLabel = l10n.backupImportConfirmDeltaPlus(delta);
    } else if (delta < 0) {
      deltaColor = theme.colorScheme.error;
      deltaLabel = l10n.backupImportConfirmDeltaMinus(delta);
    } else {
      deltaColor = theme.colorScheme.onSurfaceVariant;
      deltaLabel = l10n.backupImportConfirmDeltaZero;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72,
            child: Text(label, style: theme.textTheme.bodyMedium),
          ),
          Expanded(
            child: Text(
              l10n.backupImportConfirmCountLine(current, after),
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Text(
            deltaLabel,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: deltaColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}