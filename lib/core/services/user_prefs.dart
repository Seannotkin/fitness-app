import 'dart:convert';
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
  static const _kActivities = 'user_activities';
  static const _kDietaryFocus = 'user_dietary_focus';
  static const _kFirstLaunch = 'first_launch_date';
  static const _kLastOpen = 'last_open_date';
  static const _kStreak = 'streak_count';
  static const _kBio = 'user_bio';
  static const _kBioIsCustom = 'bio_is_custom';

  // ── Intention labels ────────────────────────────────────────────────────────
  static const intentionLabels = [
    'Find Balance',
    'Build Strength',
    'Increase Energy',
    'Improve Sleep',
  ];

  // ── Activity level labels ───────────────────────────────────────────────────
  static const activityLabels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Athlete',
  ];

  // ── Save onboarding data ────────────────────────────────────────────────────
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
    required Set<String> selectedActivities,
    required Set<String> dietaryFocus,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cleanName = name.trim().isEmpty ? 'Friend' : name.trim();
    await prefs.setBool(_kOnboardingDone, true);
    await prefs.setString(_kName, cleanName);
    await prefs.setInt(_kIntention, intention);
    await prefs.setString(_kAge, age);
    await prefs.setString(_kHeight, height);
    await prefs.setString(_kWeight, weight);
    await prefs.setDouble(_kTdee, tdee);
    await prefs.setInt(_kActivityLevel, activityLevel);
    await prefs.setInt(_kWaterGlasses, waterGlasses);
    await prefs.setInt(_kSleepQuality, sleepQuality);
    await prefs.setString(_kActivities, jsonEncode(selectedActivities.toList()));
    await prefs.setString(_kDietaryFocus, jsonEncode(dietaryFocus.toList()));

    // Generate bio on first save (only if not already customised)
    if (!(prefs.getBool(_kBioIsCustom) ?? false)) {
      await prefs.setString(
          _kBio, _generateBio(intention, selectedActivities.toList()));
    }

    // Record first launch date
    if (prefs.getString(_kFirstLaunch) == null) {
      final now = DateTime.now();
      await prefs.setString(
          _kFirstLaunch, '${_monthName(now.month)} ${now.year}');
    }
  }

  // ── Streak ──────────────────────────────────────────────────────────────────
  static Future<int> checkAndUpdateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _dateKey(DateTime.now());
    final lastOpen = prefs.getString(_kLastOpen) ?? '';
    int streak = prefs.getInt(_kStreak) ?? 1;

    if (lastOpen == today) return streak; // already opened today

    final yesterday =
        _dateKey(DateTime.now().subtract(const Duration(days: 1)));
    if (lastOpen == yesterday) {
      streak += 1;
    } else if (lastOpen.isEmpty) {
      streak = 1;
    } else {
      streak = 1; // streak broken
    }

    await prefs.setString(_kLastOpen, today);
    await prefs.setInt(_kStreak, streak);
    return streak;
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kStreak) ?? 1;
  }

  // ── Bio ─────────────────────────────────────────────────────────────────────
  static Future<String> getBio() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kBio) ?? '';
  }

  static Future<bool> isBioCustom() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kBioIsCustom) ?? false;
  }

  static Future<void> saveBio(String bio, {bool isCustom = true}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kBio, bio);
    await prefs.setBool(_kBioIsCustom, isCustom);
  }

  static Future<void> resetBioToGenerated() async {
    final prefs = await SharedPreferences.getInstance();
    final intention = prefs.getInt(_kIntention) ?? 0;
    final activitiesJson = prefs.getString(_kActivities) ?? '[]';
    final activities = List<String>.from(jsonDecode(activitiesJson));
    final bio = _generateBio(intention, activities);
    await prefs.setString(_kBio, bio);
    await prefs.setBool(_kBioIsCustom, false);
  }

  // ── Getters ─────────────────────────────────────────────────────────────────
  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnboardingDone) ?? false;
  }

  static Future<void> clearOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kName) ?? 'Friend';
  }

  static Future<String> getFirstLaunchDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kFirstLaunch) ?? 'Today';
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
    return prefs.getDouble(_kTdee) ?? 2000;
  }

  static Future<int> getIntention() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kIntention) ?? 0;
  }

  static Future<int> getActivityLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kActivityLevel) ?? 2;
  }

  static Future<int> getWaterGlasses() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kWaterGlasses) ?? 8;
  }

  static Future<int> getSleepQuality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kSleepQuality) ?? 3;
  }

  static Future<List<String>> getActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_kActivities) ?? '[]';
    return List<String>.from(jsonDecode(json));
  }

  static Future<List<String>> getDietaryFocus() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_kDietaryFocus) ?? '[]';
    return List<String>.from(jsonDecode(json));
  }

  // ── Macros from TDEE ────────────────────────────────────────────────────────
  /// Returns {protein, carbs, fats} in grams
  static Map<String, int> macrosFromTdee(double tdee) {
    return {
      'protein': (tdee * 0.075).round(),
      'carbs': (tdee * 0.098).round(),
      'fats': (tdee * 0.031).round(),
    };
  }

  /// Water goal in litres from glass count (1 glass = 250ml)
  static double waterLitres(int glasses) => glasses * 0.25;

  // ── Suggested meals by dietary focus ───────────────────────────────────────
  static List<Map<String, dynamic>> suggestedMeals(
      List<String> dietaryFocus, double tdee) {
    final isPlant = dietaryFocus.any((d) =>
        d.toLowerCase().contains('plant') ||
        d.toLowerCase().contains('vegan') ||
        d.toLowerCase().contains('vegetarian'));
    final isLowCarb = dietaryFocus.any((d) =>
        d.toLowerCase().contains('low carb') ||
        d.toLowerCase().contains('keto'));
    final isHighProtein =
        dietaryFocus.any((d) => d.toLowerCase().contains('protein'));

    if (isPlant) {
      return [
        {'name': 'Overnight Oats with Berries', 'kcal': (tdee * 0.25).round(), 'meal': 'Breakfast'},
        {'name': 'Lentil & Veggie Bowl', 'kcal': (tdee * 0.30).round(), 'meal': 'Lunch'},
        {'name': 'Tempeh Stir Fry', 'kcal': (tdee * 0.30).round(), 'meal': 'Dinner'},
        {'name': 'Apple & Almond Butter', 'kcal': (tdee * 0.10).round(), 'meal': 'Snack'},
      ];
    } else if (isLowCarb) {
      return [
        {'name': 'Eggs & Avocado', 'kcal': (tdee * 0.25).round(), 'meal': 'Breakfast'},
        {'name': 'Grilled Salmon Salad', 'kcal': (tdee * 0.30).round(), 'meal': 'Lunch'},
        {'name': 'Chicken & Roasted Veg', 'kcal': (tdee * 0.35).round(), 'meal': 'Dinner'},
        {'name': 'Handful of Nuts', 'kcal': (tdee * 0.10).round(), 'meal': 'Snack'},
      ];
    } else if (isHighProtein) {
      return [
        {'name': 'Greek Yogurt & Granola', 'kcal': (tdee * 0.20).round(), 'meal': 'Breakfast'},
        {'name': 'Chicken & Quinoa Bowl', 'kcal': (tdee * 0.30).round(), 'meal': 'Lunch'},
        {'name': 'Beef & Sweet Potato', 'kcal': (tdee * 0.35).round(), 'meal': 'Dinner'},
        {'name': 'Protein Shake', 'kcal': (tdee * 0.15).round(), 'meal': 'Snack'},
      ];
    } else {
      // Balanced
      return [
        {'name': 'Avocado Toast & Eggs', 'kcal': (tdee * 0.25).round(), 'meal': 'Breakfast'},
        {'name': 'Mediterranean Wrap', 'kcal': (tdee * 0.30).round(), 'meal': 'Lunch'},
        {'name': 'Grilled Chicken & Rice', 'kcal': (tdee * 0.30).round(), 'meal': 'Dinner'},
        {'name': 'Mixed Fruit & Nuts', 'kcal': (tdee * 0.10).round(), 'meal': 'Snack'},
      ];
    }
  }

  // ── Workout suggestions by activities + intention ───────────────────────────
  static List<Map<String, String>> suggestedWorkouts(
      List<String> activities, int intention, int activityLevel) {
    final intensity = _intensityFromLevel(activityLevel);
    final List<Map<String, String>> workouts = [];

    for (final a in activities) {
      switch (a.toLowerCase()) {
        case 'yoga':
          workouts.add({'name': 'Morning Flow Yoga', 'duration': '25 min', 'intensity': 'Low', 'icon': 'self_improvement'});
          break;
        case 'running':
          workouts.add({'name': '${intensity} Run', 'duration': '30 min', 'intensity': intensity, 'icon': 'directions_run'});
          break;
        case 'swimming':
          workouts.add({'name': 'Lap Swimming', 'duration': '40 min', 'intensity': intensity, 'icon': 'pool'});
          break;
        case 'cycling':
          workouts.add({'name': 'Cycling Session', 'duration': '45 min', 'intensity': intensity, 'icon': 'pedal_bike'});
          break;
        case 'strength':
        case 'weight training':
          workouts.add({'name': 'Strength Circuit', 'duration': '50 min', 'intensity': 'High', 'icon': 'fitness_center'});
          break;
        case 'pilates':
          workouts.add({'name': 'Core Pilates', 'duration': '35 min', 'intensity': 'Low', 'icon': 'accessibility_new'});
          break;
        case 'hiit':
          workouts.add({'name': 'HIIT Blast', 'duration': '20 min', 'intensity': 'High', 'icon': 'local_fire_department'});
          break;
        case 'meditation':
          workouts.add({'name': 'Guided Meditation', 'duration': '15 min', 'intensity': 'Low', 'icon': 'spa'});
          break;
        default:
          workouts.add({'name': '$a Session', 'duration': '30 min', 'intensity': intensity, 'icon': 'sports'});
      }
    }

    if (workouts.isEmpty) {
      workouts.add({'name': 'Full Body Workout', 'duration': '40 min', 'intensity': intensity, 'icon': 'fitness_center'});
    }

    return workouts;
  }

  static String programName(int intention) {
    switch (intention) {
      case 0: return 'Find Your Balance';
      case 1: return 'Strength in Motion';
      case 2: return 'Energy Ignition';
      case 3: return 'Deep Rest Protocol';
      default: return 'Your Program';
    }
  }

  static String intentionMessage(int intention) {
    switch (intention) {
      case 0: return 'Today is for steady grounding and balance.';
      case 1: return 'Every rep brings you closer to your strength.';
      case 2: return 'Move with purpose. Energy follows action.';
      case 3: return 'Rest is part of the work. Honor your recovery.';
      default: return 'Today is a great day to move.';
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────
  static String _dateKey(DateTime d) => '${d.year}-${d.month}-${d.day}';

  static String _monthName(int month) {
    const names = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return names[month];
  }

  static String _intensityFromLevel(int level) {
    if (level <= 1) return 'Low';
    if (level == 2) return 'Moderate';
    return 'High';
  }

  static String _generateBio(int intention, List<String> activities) {
    const lines = [
      'Finding balance in movement and rest. Dedicated to a mindful, sustainable lifestyle.',
      'Building strength one session at a time. Focused on consistent progress over perfection.',
      'Chasing energy through mindful movement. Fuelling a life lived fully.',
      'On a journey to better rest and deep recovery. Sleep is the secret weapon.',
    ];
    String bio = lines[intention.clamp(0, 3)];
    if (activities.isNotEmpty) {
      final list = activities.join(', ').toLowerCase();
      bio += ' Loves $list.';
    }
    return bio;
  }
}
