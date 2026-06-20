import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/features/catalog/presentation/pages/catalog_page.dart';
import 'package:musical_note_training/features/custom_card/presentation/pages/custom_card_page.dart';
import 'package:musical_note_training/features/deck/presentation/pages/deck_list_page.dart';
import 'package:musical_note_training/features/flash/presentation/pages/flash_page.dart';
import 'package:musical_note_training/features/home/presentation/pages/home_page.dart';
import 'package:musical_note_training/features/rhythm/presentation/pages/rhythm_page.dart';
import 'package:musical_note_training/features/settings/presentation/pages/settings_page.dart';
import 'package:musical_note_training/features/study/presentation/pages/study_page.dart';
import 'package:musical_note_training/features/weak_items/presentation/pages/weak_items_page.dart';

GoRouter createAppRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.catalog,
        builder: (context, state) => const CatalogPage(),
      ),
      GoRoute(
        path: AppRoutes.study,
        builder: (context, state) => const StudyPage(),
      ),
      GoRoute(
        path: AppRoutes.decks,
        builder: (context, state) => const DeckListPage(),
      ),
      GoRoute(
        path: AppRoutes.weakItems,
        builder: (context, state) => const WeakItemsPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.flash,
        builder: (context, state) => const FlashPage(),
      ),
      GoRoute(
        path: AppRoutes.rhythm,
        builder: (context, state) => const RhythmPage(),
      ),
      GoRoute(
        path: AppRoutes.customCard,
        builder: (context, state) => const CustomCardPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(child: Text('No route for ${state.uri}')),
    ),
  );
}