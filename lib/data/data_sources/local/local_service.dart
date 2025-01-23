import 'package:livora/data/models/user_model.dart';
import 'package:livora/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService{
  static const String LAST_LOGIN_KEY = 'last_login_date';
  static const String CURRENT_STREAK_KEY = 'current_streak';

  Future<void> checkAndUpdateLoginStreak(User user) async {
    UserRepository userRepository = UserRepository();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastLoginStr = prefs.getString(LAST_LOGIN_KEY);
    int currentStreak = prefs.getInt(CURRENT_STREAK_KEY) ?? 0;

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (lastLoginStr != null) {
      DateTime lastLogin = DateTime.parse(lastLoginStr);
      DateTime lastLoginDate =
      DateTime(lastLogin.year, lastLogin.month, lastLogin.day);

      Duration difference = today.difference(lastLoginDate);

      if (difference.inDays == 1) {
        // Add streak
        currentStreak++;
      } else if (difference.inDays == 0) {
        // Same day
        return;
      } else {
        // Streak is gone
        currentStreak = 1;
      }
    } else {
      // First time login
      currentStreak = 1;
    }

    // Update
    await prefs.setString(LAST_LOGIN_KEY, today.toIso8601String());
    await prefs.setInt(CURRENT_STREAK_KEY, currentStreak);

    // Update streak on the server
    try {
      user.streakCount++;
      await userRepository.updateStreak();
    } catch (e) {
      print('Failed to update streak on server: $e');
    }
  }
}