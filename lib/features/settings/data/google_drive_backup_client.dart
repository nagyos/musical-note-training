import 'dart:convert';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot.dart';
import 'package:musical_note_training/shared/domain/backup/user_data_snapshot_codec.dart';

/// Stores the user backup JSON in Google Drive's hidden app data folder.
class GoogleDriveBackupClient {
  GoogleDriveBackupClient({this.backupFileName = 'musical_note_training_user_data.json'});

  static const driveAppDataSpace = 'appDataFolder';
  static const driveScopes = [drive.DriveApi.driveAppdataScope];

  final String backupFileName;

  GoogleSignIn get _signIn => GoogleSignIn.instance;

  Future<GoogleSignInAccount?> currentUser() {
    return _signIn.attemptLightweightAuthentication() ?? Future.value();
  }

  Future<GoogleSignInAccount> signIn() {
    return _signIn.authenticate(scopeHint: driveScopes);
  }

  Future<void> signOut() => _signIn.signOut();

  Future<drive.DriveApi> _driveApi({required bool interactive}) async {
    var account = await currentUser();
    if (account == null && interactive) {
      account = await signIn();
    }
    if (account == null) {
      throw StateError('Google account is not signed in');
    }

    final authz =
        await account.authorizationClient.authorizationForScopes(driveScopes) ??
            await account.authorizationClient.authorizeScopes(driveScopes);

    return drive.DriveApi(authz.authClient(scopes: driveScopes));
  }

  Future<UserDataSnapshot?> downloadSnapshot({bool interactive = false}) async {
    final api = await _driveApi(interactive: interactive);
    final list = await api.files.list(
      spaces: driveAppDataSpace,
      q: "name = '$backupFileName'",
      $fields: 'files(id,name,modifiedTime)',
    );

    final files = list.files;
    final file = files != null && files.isNotEmpty ? files.first : null;
    if (file?.id == null) return null;

    final media = await api.files.get(
      file!.id!,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final bytes = await media.stream.toList();
    final json = utf8.decode(bytes.expand((chunk) => chunk).toList());
    return UserDataSnapshotCodec.decode(json);
  }

  Future<void> uploadSnapshot(
    UserDataSnapshot snapshot, {
    bool interactive = false,
  }) async {
    final api = await _driveApi(interactive: interactive);
    final json = UserDataSnapshotCodec.encode(snapshot);
    final bytes = utf8.encode(json);

    final existing = await api.files.list(
      spaces: driveAppDataSpace,
      q: "name = '$backupFileName'",
      $fields: 'files(id)',
    );

    final media = drive.Media(
      Stream.value(bytes),
      bytes.length,
      contentType: 'application/json',
    );

    final existingFiles = existing.files;
    final fileId =
        existingFiles != null && existingFiles.isNotEmpty ? existingFiles.first.id : null;
    if (fileId == null) {
      await api.files.create(
        drive.File()
          ..name = backupFileName
          ..parents = [driveAppDataSpace],
        uploadMedia: media,
      );
      return;
    }

    await api.files.update(
      drive.File()..name = backupFileName,
      fileId,
      uploadMedia: media,
    );
  }
}