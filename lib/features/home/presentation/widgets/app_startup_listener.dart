import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/core/platform/google_sign_in_support.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/backup_providers.dart';
import 'package:musical_note_training/features/settings/presentation/widgets/google_onboarding_dialog.dart';

/// Runs Google onboarding (first launch) and silent Drive sync on startup.
class AppStartupListener extends ConsumerStatefulWidget {
  const AppStartupListener({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppStartupListener> createState() => _AppStartupListenerState();
}

class _AppStartupListenerState extends ConsumerState<AppStartupListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _onStartup());
  }

  Future<void> _onStartup() async {
    if (!GoogleSignInSupport.isAvailable) return;

    final prefs = ref.read(backupPreferencesProvider);
    if (!await prefs.isOnboardingCompleted()) {
      if (!mounted) return;
      final result = await showGoogleOnboardingDialog(context);
      await prefs.setOnboardingCompleted(completed: true);
      if (result == GoogleOnboardingResult.signedIn) return;
    }

    await ref.read(googleAccountEmailProvider.notifier).syncSilentlyIfSignedIn();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}