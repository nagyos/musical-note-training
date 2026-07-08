import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/core/theme/app_theme.dart';

class MusicalNoteTrainingApp extends ConsumerWidget {
  const MusicalNoteTrainingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Musical Note Training',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}