import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const _kOnboardingDone = 'onboarding_done';
  static const _kName = 'user_name';
  static const _kAge = 'user_age';
  static const _kHeight = 'user_height';
  static const _kWeight = 'user_weight';
  static const _kTdee = 'user_tdee';
  static const _kIntention = 'user_intention';
  static const _kActivityLevel = 'user_activity_level';
  static const _kWaterGlasses = 'user_water_glasses';
  static const _kSleepQuality = 'user_sleep_quality';

  static Future<void> saveOnboarding({
    required String name,
    required int intention,
    required String age,
    required String height,
    required String weight,
    required double tdee,
    required int activityLevel,
    required int waterGlasses,
    required int sleepQuality,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingDone, true);
    await prefs.setString(_kName, name.trim().isEmpty ? 'Friend' : name.trim());
    await prefs.setInt(_kIntention, intention);
    await prefs.setString(_kAge, age);
    await prefs.setString(_kHeight, height);
    await prefs.setString(_kWeight, weight);
    await prefs.setDouble(_kTdee, tdee);
    await prefs.setInt(_kActivityLevel, activityLevel);
    await prefs.setInt(_kWaterGlasses, waterGlasses);
    await prefs.setInt(_kSleepQuality, sleepQuality);
  }

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnboardingDone) ?? false;
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kName) ?? 'Friend';
  }

  static Future<String> getAge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAge) ?? '';
  }

  static Future<String> getHeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kHeight) ?? '';
  }

  static Future<String> getWeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kWeight) ?? '';
  }

  static Future<double> getTdee() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_kTdee) ?? 0;
  }

  static Future<int> getActivityLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kActivityLevel) ?? 2;
  }

  static Future<int> getWaterGlasses() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kWaterGlasses) ?? 2;
  }

  static Future<int> getSleepQuality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kSleepQuality) ?? 3;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
