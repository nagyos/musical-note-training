import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/deck/presentation/view_models/deck_providers.dart';
import 'package:musical_note_training/features/deck/presentation/widgets/create_deck_dialog.dart';

class DeckListPage extends ConsumerWidget {
  const DeckListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final decksAsync = ref.watch(decksProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.decksTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createDeck(context, ref),
        child: const Icon(Icons.add),
      ),
      body: decksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text(l10n.loadDecksFailed('$error'))),
        data: (decks) {
          if (decks.isEmpty) {
            return Center(child: Text(l10n.noDecksHint));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: decks.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final deck = decks[index];
              return Card(
                child: ListTile(
                  title: Text(deck.name),
                  subtitle: deck.description == null
                      ? null
                      : Text(deck.description!),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go(AppRoutes.deckDetail(deck.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _createDeck(BuildContext context, WidgetRef ref) async {
    final name = await showCreateDeckDialog(context);
    if (name == null) return;

    await ref.read(deckRepositoryProvider).createDeck(name: name);
    ref.invalidate(decksProvider);
  }
}