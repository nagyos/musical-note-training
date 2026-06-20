import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/router/app_router.dart';

/// Global Riverpod providers (composition root).
///
/// Feature-specific providers live under each feature's `presentation/view_models/`.
final routerProvider = Provider<GoRouter>(createAppRouter);