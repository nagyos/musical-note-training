import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:musical_note_training/shared/data/database/app_database.dart';

/// Initializes app-wide services before [runApp].
Future<AppDatabase> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  return openAppDatabase();
}