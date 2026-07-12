import 'package:flutter/material.dart';
import 'package:musical_note_training/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/core/theme/app_theme.dart';
import 'package:musical_note_training/features/home/presentation/widgets/app_startup_listener.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';

class MusicalNoteTrainingApp extends ConsumerWidget {
  const MusicalNoteTrainingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settings = ref.watch(appSettingsProvider);

    return AppStartupListener(
      child: MaterialApp.router(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        locale: settings.uiLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}