/// Common fields for entities that may sync via Turso in later phases.
///
/// MVP stores these locally; [version] supports optimistic concurrency later.
class SyncMetadata {
  const SyncMetadata({
    required this.version,
    required this.updatedAt,
    this.lastSyncedAt,
  });

  final int version;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;

  SyncMetadata copyWith({
    int? version,
    DateTime? updatedAt,
    DateTime? lastSyncedAt,
  }) {
    return SyncMetadata(
      version: version ?? this.version,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }
}