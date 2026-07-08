import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/core/extensions/l10n_x.dart';
import 'package:musical_note_training/core/theme/app_spacing.dart';
import 'package:musical_note_training/features/deck/presentation/view_models/deck_providers.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';
import 'package:musical_note_training/shared/domain/models/card.dart' as domain;
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';

final officialNoteCardsProvider = FutureProvider<List<domain.Card>>((ref) {
  return ref
      .read(cardRepositoryProvider)
      .getCardsByCategory(CardCategoryType.note);
});

class DeckCardPickerPage extends ConsumerStatefulWidget {
  const DeckCardPickerPage({super.key, required this.deckId});

  final String deckId;

  @override
  ConsumerState<DeckCardPickerPage> createState() => _DeckCardPickerPageState();
}

class _DeckCardPickerPageState extends ConsumerState<DeckCardPickerPage> {
  final _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final answerLocale = ref.watch(answerLocaleProvider);
    final cardsAsync = ref.watch(officialNoteCardsProvider);
    final inDeckAsync = ref.watch(deckCardsProvider(widget.deckId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addOfficialCardsTitle),
        actions: [
          TextButton(
            onPressed: _selected.isEmpty ? null : _save,
            child: Text(l10n.add),
          ),
        ],
      ),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(l10n.loadFailed('$error'))),
        data: (cards) {
          final inDeck = inDeckAsync.maybeWhen(
            data: (deckCards) => deckCards.map((c) => c.cardId).toSet(),
            orElse: () => <String>{},
          );

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: cards.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, index) {
              final card = cards[index];
              final alreadyInDeck = inDeck.contains(card.id);
              final checked = _selected.contains(card.id) || alreadyInDeck;

              return CheckboxListTile(
                value: checked,
                onChanged: alreadyInDeck
                    ? null
                    : (value) {
                        setState(() {
                          if (value == true) {
                            _selected.add(card.id);
                          } else {
                            _selected.remove(card.id);
                          }
                        });
                      },
                title: Text(card.answer.resolve(answerLocale)),
                subtitle: Text(card.id),
                secondary: alreadyInDeck ? Text(l10n.cardAlreadyAdded) : null,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _save() async {
    final repo = ref.read(deckRepositoryProvider);
    for (final cardId in _selected) {
      await repo.addCardToDeck(deckId: widget.deckId, cardId: cardId);
    }
    ref.invalidate(deckCardsProvider(widget.deckId));
    ref.invalidate(deckResolvedCardsProvider(widget.deckId));
    if (mounted) context.pop();
  }
}