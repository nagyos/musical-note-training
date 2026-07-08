import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/extensions/localized_text_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/deck/presentation/view_models/deck_providers.dart';

class DeckDetailPage extends ConsumerWidget {
  const DeckDetailPage({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckAsync = ref.watch(deckProvider(deckId));
    final cardsAsync = ref.watch(deckResolvedCardsProvider(deckId));

    return Scaffold(
      appBar: AppBar(
        title: deckAsync.maybeWhen(
          data: (deck) => Text(deck?.name ?? 'Deck'),
          orElse: () => const Text('Deck'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.deckAddCards(deckId)),
        icon: const Icon(Icons.add),
        label: const Text('カード追加'),
      ),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load cards: $error')),
        data: (cards) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: cards.isEmpty
                        ? null
                        : () => context.go(AppRoutes.studyDeck(deckId)),
                    child: Text('学習する（${cards.length} 枚）'),
                  ),
                ),
              ),
              Expanded(
                child: cards.isEmpty
                    ? const Center(child: Text('カードがありません'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        itemCount: cards.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return Card(
                            child: ListTile(
                              title: Text(card.answer.resolveFrom(context)),
                              subtitle: Text(card.id),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () =>
                                    _removeCard(context, ref, card.id),
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

  Future<void> _removeCard(
    BuildContext context,
    WidgetRef ref,
    String cardId,
  ) async {
    await ref.read(deckRepositoryProvider).removeCardFromDeck(
          deckId: deckId,
          cardId: cardId,
        );
    ref.invalidate(deckCardsProvider(deckId));
    ref.invalidate(deckResolvedCardsProvider(deckId));
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('デッキを削除'),
        content: const Text('このデッキを削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await ref.read(deckRepositoryProvider).deleteDeck(deckId);
    ref.invalidate(decksProvider);
    if (context.mounted) context.go(AppRoutes.decks);
  }
}