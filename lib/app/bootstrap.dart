import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:musical_note_training/core/platform/google_sign_in_support.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart';

/// Initializes app-wide services before [runApp].
Future<AppDatabase> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  if (GoogleSignInSupport.isAvailable) {
    await GoogleSignIn.instance.initialize();
  }

  return openAppDatabase();
}