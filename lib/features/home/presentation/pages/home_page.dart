import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/extensions/localized_text_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/shared/domain/models/category.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) {
  return ref.read(cardRepositoryProvider).getCategories();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.style_outlined),
            tooltip: l10n.decksTooltip,
            onPressed: () => context.go(AppRoutes.decks),
          ),
          IconButton(
            icon: const Icon(Icons.history_edu_outlined),
            tooltip: l10n.weakItemsTooltip,
            onPressed: () => context.go(AppRoutes.weakItems),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settingsTooltip,
            onPressed: () => context.go(AppRoutes.settings),
          ),
        ],
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(l10n.loadFailed('$error'))),
        data: (categories) {
          if (categories.isEmpty) {
            return Center(child: Text(l10n.noCategories));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Card(
                child: ListTile(
                  leading: Icon(_iconFor(category.id)),
                  title: Text(category.title.resolveFrom(context)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go(AppRoutes.catalogCategory(category.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _iconFor(String categoryId) {
    return switch (categoryId) {
      'note' => Icons.music_note,
      'rest' => Icons.pause_circle_outline,
      'symbol' => Icons.tag,
      'dynamic' => Icons.volume_up_outlined,
      'tempo' => Icons.speed,
      _ => Icons.category_outlined,
    };
  }
}