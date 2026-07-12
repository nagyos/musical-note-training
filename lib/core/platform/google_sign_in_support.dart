import 'package:flutter/foundation.dart';

/// Whether [package:google_sign_in] is implemented on the current platform.
///
/// Linux / Windows / macOS desktop use a placeholder that throws
/// [UnimplementedError] on [GoogleSignIn.initialize].
abstract final class GoogleSignInSupport {
  static bool get isAvailable {
    if (kIsWeb) return true;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => true,
      _ => false,
    };
  }
}