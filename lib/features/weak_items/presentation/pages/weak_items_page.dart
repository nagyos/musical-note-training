import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';
import 'package:musical_note_training/features/weak_items/presentation/view_models/weak_item_providers.dart';

class WeakItemsPage extends ConsumerWidget {
  const WeakItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answerLocale = ref.watch(answerLocaleProvider);
    final entriesAsync = ref.watch(weakItemEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.weakItemsTitle)),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(l10n.loadFailed('$error'))),
        data: (entries) {
          if (entries.isEmpty) {
            return Center(child: Text(l10n.noWeakItems));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.go(AppRoutes.studyWeakItems),
                    child: Text(l10n.reviewWeakItems(entries.length)),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  itemCount: entries.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final weakItem = entry.weakItem;
                    final card = entry.card;
                    final title = card?.answer.resolve(answerLocale) ??
                        weakItem.cardId;
                    final accuracy =
                        (weakItem.accuracy * 100).toStringAsFixed(0);

                    return Card(
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(
                          l10n.weakItemStats(
                            weakItem.wrongCount,
                            weakItem.correctCount,
                            int.parse(accuracy),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _remove(context, ref, weakItem.id),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    String weakItemId,
  ) async {
    await ref.read(weakItemRepositoryProvider).removeWeakItem(weakItemId);
    ref.invalidate(weakItemsProvider);
    ref.invalidate(weakItemEntriesProvider);
  }
}