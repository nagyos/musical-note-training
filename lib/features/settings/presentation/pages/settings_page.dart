import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/shared/widgets/app_page_app_bar.dart';
import 'package:musical_note_training/features/settings/domain/note_name_style.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';
import 'package:musical_note_training/features/settings/presentation/widgets/settings_backup_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      appBar: AppPageAppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.settingsLanguage, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'ja', label: Text(l10n.settingsLanguageJa)),
              ButtonSegment(value: 'en', label: Text(l10n.settingsLanguageEn)),
            ],
            selected: {settings.uiLocaleCode},
            onSelectionChanged: (selection) {
              notifier.setUiLocaleCode(selection.first);
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.settingsNoteNames, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<NoteNameStyle>(
            segments: [
              ButtonSegment(
                value: NoteNameStyle.solfege,
                label: Text(l10n.settingsNoteNamesSolfege),
              ),
              ButtonSegment(
                value: NoteNameStyle.letter,
                label: Text(l10n.settingsNoteNamesLetter),
              ),
            ],
            selected: {settings.noteNameStyle},
            onSelectionChanged: (selection) {
              notifier.setNoteNameStyle(selection.first);
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          const SettingsBackupSection(),
        ],
      ),
    );
  }
}