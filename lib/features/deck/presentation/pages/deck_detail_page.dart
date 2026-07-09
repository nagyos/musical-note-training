import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/app/router/routes.dart';
import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/shared/widgets/app_page_app_bar.dart';
import 'package:musical_note_training/features/deck/presentation/view_models/deck_providers.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';

class DeckDetailPage extends ConsumerWidget {
  const DeckDetailPage({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final answerLocale = ref.watch(answerLocaleProvider);
    final deckAsync = ref.watch(deckProvider(deckId));
    final cardsAsync = ref.watch(deckResolvedCardsProvider(deckId));

    return Scaffold(
      appBar: AppPageAppBar(
        title: deckAsync.maybeWhen(
          data: (deck) => Text(deck?.name ?? l10n.deckFallbackTitle),
          orElse: () => Text(l10n.deckFallbackTitle),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.deckAddCards(deckId)),
        icon: const Icon(Icons.add),
        label: Text(l10n.addCards),
      ),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text(l10n.loadDeckCardsFailed('$error'))),
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
                        : () => context.push(AppRoutes.studyDeck(deckId)),
                    child: Text(l10n.studyDeck(cards.length)),
                  ),
                ),
              ),
              Expanded(
                child: cards.isEmpty
                    ? Center(child: Text(l10n.noCardsInDeck))
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
                              title: Text(card.answer.resolve(answerLocale)),
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
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteDeckTitle),
        content: Text(l10n.deleteDeckMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await ref.read(deckRepositoryProvider).deleteDeck(deckId);
    ref.invalidate(decksProvider);
    if (!context.mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.decks);
    }
  }
}