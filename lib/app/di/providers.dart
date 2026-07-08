import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/router/app_router.dart';
import 'package:musical_note_training/features/study/domain/study_launch_service.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart';
import 'package:musical_note_training/shared/data/repositories/asset_card_repository.dart';
import 'package:musical_note_training/shared/data/repositories/empty_deck_repository.dart';
import 'package:musical_note_training/shared/data/repositories/empty_weak_item_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/card_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/deck_repository.dart';
import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';

/// Global Riverpod providers (composition root).
///
/// Feature-specific providers live under each feature's `presentation/view_models/`.
final routerProvider = Provider<GoRouter>(createAppRouter);

/// Local SQLite database (drift). Overridden in [main] after [bootstrap].
final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => throw StateError('appDatabaseProvider must be overridden at startup'),
);

final cardRepositoryProvider = Provider<CardRepository>(
  (ref) => AssetCardRepository(),
);

final deckRepositoryProvider = Provider<DeckRepository>(
  (ref) => const EmptyDeckRepository(),
);

final weakItemRepositoryProvider = Provider<WeakItemRepository>(
  (ref) => const EmptyWeakItemRepository(),
);

final studyLaunchServiceProvider = Provider<StudyLaunchService>(
  (ref) => StudyLaunchService(
    cardRepository: ref.watch(cardRepositoryProvider),
    deckRepository: ref.watch(deckRepositoryProvider),
    weakItemRepository: ref.watch(weakItemRepositoryProvider),
  ),
);

/// UI locale code until settings (T-103) provides a toggle.
final appLocaleProvider = Provider<String>((ref) => 'ja');