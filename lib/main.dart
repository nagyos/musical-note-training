import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/app.dart';
import 'package:musical_note_training/app/bootstrap.dart';
import 'package:musical_note_training/app/di/providers.dart';

Future<void> main() async {
  final database = await bootstrap();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
      ],
      child: const MusicalNoteTrainingApp(),
    ),
  );
}