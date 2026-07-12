import 'package:musical_note_training/features/settings/data/google_drive_backup_client.dart';
import 'package:musical_note_training/features/settings/domain/user_data_backup_service.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';

/// Pulls and pushes user data through Google Drive app data storage.
class UserDataSyncService {
  UserDataSyncService({
    required UserDataBackupService backupService,
    required GoogleDriveBackupClient driveClient,
  }) : _backupService = backupService,
       _driveClient = driveClient;

  final UserDataBackupService _backupService;
  final GoogleDriveBackupClient _driveClient;

  Future<void> syncWithDrive({bool interactive = true}) async {
    final remote = await _driveClient.downloadSnapshot(interactive: interactive);
    final local = await _backupService.captureLocalSnapshot();

    if (remote == null) {
      await _driveClient.uploadSnapshot(local, interactive: interactive);
      return;
    }

    if (remote.exportedAt.isAfter(local.exportedAt)) {
      await _backupService.applyRemoteSnapshot(remote);
      final merged = await _backupService.captureLocalSnapshot();
      await _driveClient.uploadSnapshot(merged, interactive: interactive);
      return;
    }

    if (local.exportedAt.isAfter(remote.exportedAt)) {
      await _driveClient.uploadSnapshot(local, interactive: interactive);
      return;
    }

    await _backupService.applyRemoteSnapshot(remote);
    final merged = await _backupService.captureLocalSnapshot();
    await _driveClient.uploadSnapshot(merged, interactive: interactive);
  }

  Future<UserDataSnapshot?> peekRemoteSnapshot({bool interactive = false}) {
    return _driveClient.downloadSnapshot(interactive: interactive);
  }
}