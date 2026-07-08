import 'package:musical_note_training/shared/data/database/app_database.dart'
    as db;
import 'package:musical_note_training/shared/domain/models/deck.dart' as domain;
import 'package:musical_note_training/shared/domain/models/deck_card.dart'
    as domain;
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

abstract final class DeckMapper {
  static domain.Deck toDomain(db.Deck row) {
    return domain.Deck(
      id: row.id,
      name: row.name,
      description: row.description,
      createdAt: row.createdAt,
      sync: SyncMetadata(
        version: row.version,
        updatedAt: row.updatedAt,
        lastSyncedAt: row.lastSyncedAt,
      ),
    );
  }

  static domain.DeckCard toDeckCardDomain(db.DeckCard row) {
    return domain.DeckCard(
      deckId: row.deckId,
      cardId: row.cardId,
      sortOrder: row.sortOrder,
      addedAt: row.addedAt,
    );
  }
}