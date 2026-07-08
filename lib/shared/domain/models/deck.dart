import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';

/// User-created flashcard deck.
class Deck {
  const Deck({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.sync,
    this.description,
  });

  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final SyncMetadata sync;

  Deck copyWith({
    String? name,
    String? description,
    SyncMetadata? sync,
  }) {
    return Deck(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt,
      sync: sync ?? this.sync,
    );
  }
}