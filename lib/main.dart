import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/app.dart';
import 'package:musical_note_training/app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(
    () => runApp(
      const ProviderScope(
        child: MusicalNoteTrainingApp(),
      ),
    ),
  );
}