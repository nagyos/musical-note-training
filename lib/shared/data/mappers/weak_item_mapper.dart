import 'package:musical_note_training/shared/data/database/app_database.dart'
    as db;
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart'
    as domain;

abstract final class WeakItemMapper {
  static domain.WeakItem toDomain(db.WeakItem row) {
    return domain.WeakItem(
      id: row.id,
      cardId: row.cardId,
      wrongCount: row.wrongCount,
      correctCount: row.correctCount,
      lastAnsweredAt: row.lastAnsweredAt,
      sync: SyncMetadata(
        version: row.version,
        updatedAt: row.updatedAt,
        lastSyncedAt: row.lastSyncedAt,
      ),
    );
  }
}