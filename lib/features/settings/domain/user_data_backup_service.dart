import 'package:musical_note_training/features/settings/data/settings_repository.dart';
import 'package:musical_note_training/features/settings/domain/settings_snapshot_mapper.dart';
import 'package:musical_note_training/shared/data/backup/drift_user_data_backup_store.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_merger.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot_codec.dart';

/// Orchestrates export, import, and merge of portable user data.
class UserDataBackupService {
  UserDataBackupService({
    required DriftUserDataBackupStore store,
    required SettingsRepository settingsRepository,
  })  : _store = store,
        _settingsRepository = settingsRepository;

  final DriftUserDataBackupStore _store;
  final SettingsRepository _settingsRepository;

  Future<UserDataSnapshot> captureLocalSnapshot() async {
    final settings = await _settingsRepository.load();
    return _store.exportSnapshot(
      settings: SettingsSnapshotMapper.fromAppSettings(settings),
    );
  }

  Future<String> exportToJson() async {
    final snapshot = await captureLocalSnapshot();
    return UserDataSnapshotCodec.encode(snapshot);
  }

  Future<void> importFromJson(String json, {required bool merge}) async {
    final incoming = UserDataSnapshotCodec.decode(json);
    if (merge) {
      final local = await captureLocalSnapshot();
      final merged = UserDataMerger.merge(local: local, remote: incoming);
      await _apply(merged);
      return;
    }
    await _apply(incoming);
  }

  Future<void> applyRemoteSnapshot(UserDataSnapshot remote) async {
    final local = await captureLocalSnapshot();
    final merged = UserDataMerger.merge(local: local, remote: remote);
    await _apply(merged);
  }

  Future<void> pushLocalToRemote(UserDataSnapshot remoteBaseline) async {
    final local = await captureLocalSnapshot();
    final merged = UserDataMerger.merge(local: local, remote: remoteBaseline);
    await _apply(merged);
  }

  Future<void> _apply(UserDataSnapshot snapshot) async {
    await _store.applySnapshot(snapshot);
    await _settingsRepository.save(
      SettingsSnapshotMapper.toAppSettings(snapshot.settings),
    );
  }
}