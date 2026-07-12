import 'package:shared_preferences/shared_preferences.dart';

/// Persists backup / Google sync UI state (not user data).
class BackupPreferences {
  static const onboardingCompletedKey = 'google_onboarding_completed';
  static const linkedEmailKey = 'google_account_email';

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingCompletedKey) ?? false;
  }

  Future<void> setOnboardingCompleted({required bool completed}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompletedKey, completed);
  }

  Future<String?> linkedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(linkedEmailKey);
  }

  Future<void> setLinkedEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    if (email == null) {
      await prefs.remove(linkedEmailKey);
      return;
    }
    await prefs.setString(linkedEmailKey, email);
  }
}