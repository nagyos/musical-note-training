import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

final weakItemsProvider = FutureProvider<List<WeakItem>>((ref) {
  return ref.read(weakItemRepositoryProvider).getWeakItems();
});

typedef WeakItemCardEntry = ({WeakItem weakItem, Card? card});

final weakItemEntriesProvider =
    FutureProvider<List<WeakItemCardEntry>>((ref) async {
  final weakItems = await ref.watch(weakItemsProvider.future);
  final cardRepo = ref.read(cardRepositoryProvider);
  final entries = <WeakItemCardEntry>[];

  for (final weakItem in weakItems) {
    final card = await cardRepo.getCardById(weakItem.cardId);
    entries.add((weakItem: weakItem, card: card));
  }
  return entries;
});