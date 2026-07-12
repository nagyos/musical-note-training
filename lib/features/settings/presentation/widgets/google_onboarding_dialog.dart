import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/backup_providers.dart';

enum GoogleOnboardingResult { signedIn, skipped }

Future<GoogleOnboardingResult?> showGoogleOnboardingDialog(BuildContext context) {
  return showDialog<GoogleOnboardingResult>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _GoogleOnboardingDialog(),
  );
}

class _GoogleOnboardingDialog extends ConsumerStatefulWidget {
  const _GoogleOnboardingDialog();

  @override
  ConsumerState<_GoogleOnboardingDialog> createState() =>
      _GoogleOnboardingDialogState();
}

class _GoogleOnboardingDialogState extends ConsumerState<_GoogleOnboardingDialog> {
  bool _busy = false;

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      await ref.read(googleAccountEmailProvider.notifier).signInAndSync();
      if (!mounted) return;
      Navigator.pop(context, GoogleOnboardingResult.signedIn);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.backupGoogleSignInFailed)),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.onboardingGoogleTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingGoogleBody),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.onboardingGoogleBenefit,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _busy
              ? null
              : () => Navigator.pop(context, GoogleOnboardingResult.skipped),
          child: Text(l10n.onboardingGoogleSkip),
        ),
        FilledButton(
          onPressed: _busy ? null : _signIn,
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.onboardingGoogleSignIn),
        ),
      ],
    );
  }
}