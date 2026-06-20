import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

typedef AppRunner = void Function();

/// Initializes app-wide services before [runApp].
///
/// Add database, preferences, and other async setup here as the app grows.
Future<void> bootstrap(AppRunner runApp) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  runApp();
}