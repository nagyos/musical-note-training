import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/platform/google_sign_in_support.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/settings/data/backup_file_io.dart';
import 'package:musical_note_training/features/settings/domain/backup_import_preview.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/backup_providers.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';
import 'package:musical_note_training/features/settings/presentation/widgets/backup_help_dialog.dart';
import 'package:musical_note_training/features/settings/presentation/widgets/backup_import_confirm_dialog.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot_codec.dart';

class SettingsBackupSection extends ConsumerStatefulWidget {
  const SettingsBackupSection({super.key});

  @override
  ConsumerState<SettingsBackupSection> createState() =>
      _SettingsBackupSectionState();
}

class _SettingsBackupSectionState extends ConsumerState<SettingsBackupSection> {
  bool _busy = false;

  Future<void> _runBusy(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signIn() async {
    await _runBusy(() async {
      try {
        await ref.read(googleAccountEmailProvider.notifier).signInAndSync();
        if (!mounted) return;
        _showMessage(context.l10n.backupSyncSuccess);
      } catch (error) {
        if (!mounted) return;
        _showMessage(context.l10n.backupGoogleSignInFailed);
      }
    });
  }

  Future<void> _signOut() async {
    await _runBusy(() async {
      await ref.read(googleAccountEmailProvider.notifier).signOut();
      if (!mounted) return;
      _showMessage(context.l10n.backupGoogleSignedOut);
    });
  }

  Future<void> _syncNow() async {
    await _runBusy(() async {
      try {
        await ref.read(googleAccountEmailProvider.notifier).syncNow();
        if (!mounted) return;
        _showMessage(context.l10n.backupSyncSuccess);
      } catch (error) {
        if (!mounted) return;
        _showMessage(context.l10n.backupSyncFailed('$error'));
      }
    });
  }

  Future<void> _exportAndShare() async {
    final l10n = context.l10n;
    await _runBusy(() async {
      try {
        final json = await ref.read(userDataBackupServiceProvider).exportToJson();
        final path = await BackupFileIo.exportJson(
          json,
          shareSubject: l10n.backupExportShareSubject,
        );
        if (!mounted) return;
        if (path == null) return;
        if (BackupFileIo.exportUsesSaveDialog) {
          _showMessage(l10n.backupExportSaved(path));
        } else {
          _showMessage(l10n.backupExportSuccess);
        }
      } catch (error) {
        if (!mounted) return;
        _showMessage(l10n.backupExportFailed('$error'));
      }
    });
  }

  Future<void> _importBackup() async {
    final l10n = context.l10n;

    String? json;
    try {
      json = await BackupFileIo.pickJsonContent();
    } catch (error) {
      if (!mounted) return;
      _showMessage(l10n.backupImportFailed('$error'));
      return;
    }
    if (json == null || !mounted) return;
    final backupJson = json;

    final UserDataSnapshot snapshot;
    try {
      snapshot = UserDataSnapshotCodec.decode(backupJson);
    } catch (error) {
      if (!mounted) return;
      _showMessage(l10n.backupImportFailed('$error'));
      return;
    }

    final localeCode = ref.read(appSettingsProvider).uiLocaleCode;
    final local = await ref.read(userDataBackupServiceProvider).captureLocalSnapshot();
    final preview = BackupImportPreview(local: local, remote: snapshot);
    final confirmed = await showBackupImportConfirmDialog(
      context,
      preview: preview,
      localeCode: localeCode,
    );
    if (!confirmed || !mounted) return;

    await _runBusy(() async {
      try {
        await ref.read(userDataBackupServiceProvider).importFromJson(
              backupJson,
              merge: false,
            );
        if (ref.read(googleAccountEmailProvider) != null) {
          await ref.read(googleAccountEmailProvider.notifier).syncNow();
        } else {
          await ref.read(googleAccountEmailProvider.notifier).reloadLocalDataOnly();
        }
        if (!mounted) return;
        _showMessage(l10n.backupImportSuccess);
      } catch (error) {
        if (!mounted) return;
        _showMessage(l10n.backupImportFailed('$error'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final googleAvailable = GoogleSignInSupport.isAvailable;
    final email = ref.watch(googleAccountEmailProvider);
    final signedIn = googleAvailable && email != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.settingsBackupTitle, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        if (googleAvailable) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    signedIn
                        ? l10n.backupGoogleLinked(email)
                        : l10n.backupGoogleNotLinked,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (signedIn)
                    OutlinedButton(
                      onPressed: _busy ? null : _signOut,
                      child: Text(l10n.backupGoogleSignOut),
                    )
                  else
                    FilledButton(
                      onPressed: _busy ? null : _signIn,
                      child: Text(l10n.backupGoogleSignIn),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          FilledButton.tonal(
            onPressed: _busy || !signedIn ? null : _syncNow,
            child: Text(l10n.backupSyncNow),
          ),
          const SizedBox(height: AppSpacing.sm),
        ] else ...[
          Text(
            l10n.backupGoogleUnavailableDesktop,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        FilledButton.tonal(
          onPressed: _busy ? null : _exportAndShare,
          child: Text(
            BackupFileIo.exportUsesSaveDialog
                ? l10n.backupExportSaveFile
                : l10n.backupExportShare,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton(
          onPressed: _busy ? null : _importBackup,
          child: Text(l10n.backupImportPickFile),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextButton(
          onPressed: _busy ? null : () => showBackupHelpDialog(context),
          child: Text(l10n.backupHelpLink),
        ),
        if (_busy) ...[
          const SizedBox(height: AppSpacing.sm),
          const Center(child: LinearProgressIndicator()),
        ],
      ],
    );
  }
}