import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musical_note_training/app/di/providers.dart';
import 'package:musical_note_training/features/deck/presentation/view_models/deck_providers.dart';
import 'package:musical_note_training/features/settings/data/backup_preferences.dart';
import 'package:musical_note_training/features/settings/data/google_drive_backup_client.dart';
import 'package:musical_note_training/features/settings/domain/user_data_backup_service.dart';
import 'package:musical_note_training/features/settings/domain/user_data_sync_service.dart';
import 'package:musical_note_training/features/settings/presentation/view_models/settings_providers.dart';
import 'package:musical_note_training/features/weak_items/presentation/view_models/weak_item_providers.dart';
import 'package:musical_note_training/shared/data/backup/drift_user_data_backup_store.dart';

final backupPreferencesProvider = Provider<BackupPreferences>(
  (ref) => BackupPreferences(),
);

final googleDriveBackupClientProvider = Provider<GoogleDriveBackupClient>(
  (ref) => GoogleDriveBackupClient(),
);

final driftUserDataBackupStoreProvider = Provider<DriftUserDataBackupStore>(
  (ref) => DriftUserDataBackupStore(ref.watch(appDatabaseProvider)),
);

final userDataBackupServiceProvider = Provider<UserDataBackupService>(
  (ref) => UserDataBackupService(
    store: ref.watch(driftUserDataBackupStoreProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ),
);

final userDataSyncServiceProvider = Provider<UserDataSyncService>(
  (ref) => UserDataSyncService(
    backupService: ref.watch(userDataBackupServiceProvider),
    driveClient: ref.watch(googleDriveBackupClientProvider),
  ),
);

/// Cached Google account email for UI. Updated on sign-in/out and startup.
final googleAccountEmailProvider =
    NotifierProvider<GoogleAccountEmailNotifier, String?>(
      GoogleAccountEmailNotifier.new,
    );

class GoogleAccountEmailNotifier extends Notifier<String?> {
  @override
  String? build() {
    Future.microtask(_loadFromStorage);
    return null;
  }

  Future<void> _loadFromStorage() async {
    final email = await ref.read(backupPreferencesProvider).linkedEmail();
    if (state != email) state = email;
  }

  Future<void> reloadLocalDataOnly() => _refreshAppData();

  Future<void> refreshFromSignIn() async {
    final account = await ref.read(googleDriveBackupClientProvider).currentUser();
    final email = account?.email;
    state = email;
    await ref.read(backupPreferencesProvider).setLinkedEmail(email);
  }

  Future<void> signInAndSync() async {
    final client = ref.read(googleDriveBackupClientProvider);
    final account = await client.signIn();
    state = account.email;
    await ref.read(backupPreferencesProvider).setLinkedEmail(account.email);
    await ref.read(userDataSyncServiceProvider).syncWithDrive();
    await _refreshAppData();
  }

  Future<void> signOut() async {
    await ref.read(googleDriveBackupClientProvider).signOut();
    state = null;
    await ref.read(backupPreferencesProvider).setLinkedEmail(null);
  }

  Future<void> syncNow() async {
    await ref.read(userDataSyncServiceProvider).syncWithDrive();
    await _refreshAppData();
  }

  Future<void> syncSilentlyIfSignedIn() async {
    final account = await ref.read(googleDriveBackupClientProvider).currentUser();
    if (account == null) return;
    state = account.email;
    await ref.read(backupPreferencesProvider).setLinkedEmail(account.email);
    await ref
        .read(userDataSyncServiceProvider)
        .syncWithDrive(interactive: false);
    await _refreshAppData();
  }

  Future<void> _refreshAppData() async {
    await ref.read(appSettingsProvider.notifier).reloadFromStorage();
    ref.invalidate(decksProvider);
    ref.invalidate(weakItemsProvider);
    ref.invalidate(weakItemEntriesProvider);
  }
}

