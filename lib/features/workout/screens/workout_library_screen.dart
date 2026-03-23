import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../../core/services/user_prefs.dart';
import '../../ai_coach/screens/ai_coach_screen.dart';
import '../../analytics/screens/progress_analytics_screen.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
import '../../profile/screens/profile_screen.dart';
import 'exercise_detail_screen.dart';

class WorkoutLibraryScreen extends StatefulWidget {
  const WorkoutLibraryScreen({super.key});

  @override
  State<WorkoutLibraryScreen> createState() => _WorkoutLibraryScreenState();
}

class _WorkoutLibraryScreenState extends State<WorkoutLibraryScreen> {
  int _currentNavIndex = 2;
  int _selectedCategory = 0;
  int _intention = 0;
  int _activityLevel = 2;
  List<String> _activities = [];
  List<Map<String, String>> _suggestedWorkouts = [];

  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _onSurface = Color(0xFF303333);
  static const _secondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final intention = await UserPrefs.getIntention();
    final activityLevel = await UserPrefs.getActivityLevel();
    final activities = await UserPrefs.getActivities();
    if (mounted) {
      setState(() {
        _intention = intention;
        _activityLevel = activityLevel;
        _activities = activities;
        _suggestedWorkouts = UserPrefs.suggestedWorkouts(activities, intention, activityLevel);
      });
    }
  }

  static const _categories = [
    'All', 'Chest', 'Back', 'Shoulders', 'Arms', 'Legs', 'Core', 'Flexibility',
  ];

  static const List<Map<String, dynamic>> _exercises = [
    // ── Chest ──
    {
      'title': 'Barbell Bench Press',
      'category': 'Chest',
      'duration': '40 min',
      'tag': 'Strength',
      'sub': 'Chest · Triceps · Front Delts',
      'sets': 4, 'reps': 8, 'weight': 60,
      'muscles': ['Chest (Primary)', 'Triceps', 'Front Delts'],
      'tips': ['Retract your shoulder blades', 'Touch bar to lower chest', 'Drive feet into the floor'],
      'restSeconds': 90,
      'icon': 'fitness_center',
    },
    {
      'title': 'Incline Dumbbell Press',
      'category': 'Chest',
      'duration': '35 min',
      'tag': 'Hypertrophy',
      'sub': 'Upper Chest · Shoulders',
      'sets': 3, 'reps': 10, 'weight': 24,
      'muscles': ['Upper Chest (Primary)', 'Front Delts', 'Triceps'],
      'tips': ['Set bench to 30–45°', 'Elbows at 75° angle', 'Full stretch at the bottom'],
      'restSeconds': 75,
      'icon': 'fitness_center',
    },
    {
      'title': 'Cable Chest Fly',
      'category': 'Chest',
      'duration': '25 min',
      'tag': 'Isolation',
      'sub': 'Inner Chest · Pecs',
      'sets': 3, 'reps': 12, 'weight': 15,
      'muscles': ['Chest (Primary)', 'Front Delts'],
      'tips': ['Slight bend in elbows throughout', 'Squeeze chest at peak', 'Control the eccentric'],
      'restSeconds': 60,
      'icon': 'sync_alt',
    },
    {
      'title': 'Push-Up',
      'category': 'Chest',
      'duration': '20 min',
      'tag': 'Bodyweight',
      'sub': 'Chest · Triceps · Core',
      'sets': 4, 'reps': 15, 'weight': 0,
      'muscles': ['Chest (Primary)', 'Triceps', 'Core'],
      'tips': ['Keep body in a straight line', 'Elbows at 45°', 'Full range of motion'],
      'restSeconds': 60,
      'icon': 'accessibility_new',
    },
    {
      'title': 'Chest Dip',
      'category': 'Chest',
      'duration': '30 min',
      'tag': 'Compound',
      'sub': 'Lower Chest · Triceps',
      'sets': 3, 'reps': 10, 'weight': 0,
      'muscles': ['Lower Chest (Primary)', 'Triceps', 'Front Delts'],
      'tips': ['Lean slightly forward', 'Lower until elbows 90°', 'Don\'t lock out at top'],
      'restSeconds': 75,
      'icon': 'arrow_downward',
    },
    // ── Back ──
    {
      'title': 'Deadlift',
      'category': 'Back',
      'duration': '45 min',
      'tag': 'Strength',
      'sub': 'Full Back · Hamstrings · Glutes',
      'sets': 4, 'reps': 5, 'weight': 100,
      'muscles': ['Lower Back (Primary)', 'Hamstrings', 'Glutes', 'Traps'],
      'tips': ['Bar over mid-foot', 'Neutral spine throughout', 'Push the floor away'],
      'restSeconds': 120,
      'icon': 'fitness_center',
    },
    {
      'title': 'Pull-Up',
      'category': 'Back',
      'duration': '30 min',
      'tag': 'Bodyweight',
      'sub': 'Lats · Biceps · Rear Delts',
      'sets': 4, 'reps': 8, 'weight': 0,
      'muscles': ['Lats (Primary)', 'Biceps', 'Rear Delts'],
      'tips': ['Full hang at bottom', 'Drive elbows down to hips', 'Chin clears the bar'],
      'restSeconds': 90,
      'icon': 'arrow_upward',
    },
    {
      'title': 'Barbell Row',
      'category': 'Back',
      'duration': '35 min',
      'tag': 'Compound',
      'sub': 'Mid Back · Lats · Biceps',
      'sets': 4, 'reps': 8, 'weight': 70,
      'muscles': ['Mid Back (Primary)', 'Lats', 'Biceps'],
      'tips': ['Hinge at 45°', 'Pull to lower sternum', 'Squeeze at the top'],
      'restSeconds': 90,
      'icon': 'fitness_center',
    },
    {
      'title': 'Lat Pulldown',
      'category': 'Back',
      'duration': '30 min',
      'tag': 'Hypertrophy',
      'sub': 'Lats · Teres Major',
      'sets': 3, 'reps': 12, 'weight': 55,
      'muscles': ['Lats (Primary)', 'Teres Major', 'Biceps'],
      'tips': ['Lean back slightly', 'Pull to upper chest', 'Full stretch at top'],
      'restSeconds': 60,
      'icon': 'sync_alt',
    },
    {
      'title': 'Face Pull',
      'category': 'Back',
      'duration': '20 min',
      'tag': 'Corrective',
      'sub': 'Rear Delts · Rotator Cuff',
      'sets': 3, 'reps': 15, 'weight': 20,
      'muscles': ['Rear Delts (Primary)', 'Rotator Cuff', 'Traps'],
      'tips': ['Pull to eye level', 'External rotation at end', 'Light weight, perfect form'],
      'restSeconds': 45,
      'icon': 'self_improvement',
    },
    // ── Shoulders ──
    {
      'title': 'Overhead Press',
      'category': 'Shoulders',
      'duration': '40 min',
      'tag': 'Strength',
      'sub': 'Front & Side Delts · Triceps',
      'sets': 4, 'reps': 6, 'weight': 50,
      'muscles': ['Front Delts (Primary)', 'Side Delts', 'Triceps'],
      'tips': ['Brace core hard', 'Bar path slightly back', 'Shrug at lockout'],
      'restSeconds': 90,
      'icon': 'fitness_center',
    },
    {
      'title': 'Lateral Raise',
      'category': 'Shoulders',
      'duration': '25 min',
      'tag': 'Isolation',
      'sub': 'Side Delts · Width Builder',
      'sets': 4, 'reps': 15, 'weight': 8,
      'muscles': ['Side Delts (Primary)'],
      'tips': ['Lead with elbows', 'Slight forward lean', 'Pause at shoulder height'],
      'restSeconds': 45,
      'icon': 'swap_horiz',
    },
    {
      'title': 'Arnold Press',
      'category': 'Shoulders',
      'duration': '30 min',
      'tag': 'Hypertrophy',
      'sub': 'All Three Delt Heads',
      'sets': 3, 'reps': 12, 'weight': 14,
      'muscles': ['Front Delts (Primary)', 'Side Delts', 'Rear Delts'],
      'tips': ['Rotate palms as you press', 'Start with palms facing you', 'Control the rotation down'],
      'restSeconds': 60,
      'icon': 'rotate_right',
    },
    {
      'title': 'Rear Delt Fly',
      'category': 'Shoulders',
      'duration': '20 min',
      'tag': 'Corrective',
      'sub': 'Rear Delts · Posture',
      'sets': 3, 'reps': 15, 'weight': 6,
      'muscles': ['Rear Delts (Primary)', 'Traps'],
      'tips': ['Hinge forward 90°', 'Pinkies higher than thumbs', 'Squeeze shoulder blades'],
      'restSeconds': 45,
      'icon': 'self_improvement',
    },
    {
      'title': 'Front Raise',
      'category': 'Shoulders',
      'duration': '20 min',
      'tag': 'Isolation',
      'sub': 'Front Delts · Anterior',
      'sets': 3, 'reps': 12, 'weight': 10,
      'muscles': ['Front Delts (Primary)', 'Upper Chest'],
      'tips': ['Raise to shoulder height', 'Slight elbow bend', 'Don\'t swing the weight'],
      'restSeconds': 45,
      'icon': 'arrow_upward',
    },
    // ── Arms ──
    {
      'title': 'Barbell Curl',
      'category': 'Arms',
      'duration': '25 min',
      'tag': 'Strength',
      'sub': 'Biceps · Forearms',
      'sets': 4, 'reps': 8, 'weight': 30,
      'muscles': ['Biceps (Primary)', 'Brachialis', 'Forearms'],
      'tips': ['Keep elbows at your sides', 'Supinate at the top', 'Full extension at bottom'],
      'restSeconds': 60,
      'icon': 'fitness_center',
    },
    {
      'title': 'Tricep Pushdown',
      'category': 'Arms',
      'duration': '20 min',
      'tag': 'Isolation',
      'sub': 'Triceps · Lateral Head',
      'sets': 3, 'reps': 12, 'weight': 25,
      'muscles': ['Triceps (Primary)', 'Lateral Head'],
      'tips': ['Lock elbows at sides', 'Full extension at bottom', 'Slow eccentric'],
      'restSeconds': 45,
      'icon': 'arrow_downward',
    },
    {
      'title': 'Hammer Curl',
      'category': 'Arms',
      'duration': '20 min',
      'tag': 'Hypertrophy',
      'sub': 'Brachialis · Forearms',
      'sets': 3, 'reps': 12, 'weight': 14,
      'muscles': ['Brachialis (Primary)', 'Biceps', 'Forearms'],
      'tips': ['Neutral grip throughout', 'Alternate arms', 'No momentum'],
      'restSeconds': 45,
      'icon': 'fitness_center',
    },
    {
      'title': 'Skull Crusher',
      'category': 'Arms',
      'duration': '25 min',
      'tag': 'Compound',
      'sub': 'Triceps Long Head',
      'sets': 3, 'reps': 10, 'weight': 20,
      'muscles': ['Triceps Long Head (Primary)', 'Lateral Head'],
      'tips': ['Lower bar to forehead', 'Keep elbows tucked', 'Press back to start'],
      'restSeconds': 60,
      'icon': 'fitness_center',
    },
    {
      'title': 'Preacher Curl',
      'category': 'Arms',
      'duration': '20 min',
      'tag': 'Isolation',
      'sub': 'Biceps · Peak Contraction',
      'sets': 3, 'reps': 12, 'weight': 20,
      'muscles': ['Biceps (Primary)', 'Brachialis'],
      'tips': ['Full stretch at bottom', 'Don\'t let shoulder rise', 'Squeeze at top'],
      'restSeconds': 45,
      'icon': 'fitness_center',
    },
    // ── Legs ──
    {
      'title': 'Romanian Deadlift',
      'category': 'Legs',
      'duration': '40 min',
      'tag': 'Strength',
      'sub': 'Hamstrings · Glutes · Lower Back',
      'sets': 4, 'reps': 10, 'weight': 60,
      'muscles': ['Hamstrings (Primary)', 'Glutes', 'Lower Back'],
      'tips': ['Hinge at the hips', 'Bar stays close to body', 'Feel stretch in hamstrings'],
      'restSeconds': 90,
      'icon': 'fitness_center',
    },
    {
      'title': 'Back Squat',
      'category': 'Legs',
      'duration': '45 min',
      'tag': 'Strength',
      'sub': 'Quads · Glutes · Hamstrings',
      'sets': 4, 'reps': 6, 'weight': 80,
      'muscles': ['Quads (Primary)', 'Glutes', 'Hamstrings'],
      'tips': ['Feet shoulder-width apart', 'Knees track over toes', 'Break parallel depth'],
      'restSeconds': 120,
      'icon': 'fitness_center',
    },
    {
      'title': 'Leg Press',
      'category': 'Legs',
      'duration': '35 min',
      'tag': 'Hypertrophy',
      'sub': 'Quads · Glutes',
      'sets': 4, 'reps': 12, 'weight': 120,
      'muscles': ['Quads (Primary)', 'Glutes', 'Hamstrings'],
      'tips': ['Feet mid-platform', 'Don\'t lock out knees', 'Full depth of motion'],
      'restSeconds': 75,
      'icon': 'fitness_center',
    },
    {
      'title': 'Bulgarian Split Squat',
      'category': 'Legs',
      'duration': '35 min',
      'tag': 'Unilateral',
      'sub': 'Quads · Glutes · Balance',
      'sets': 3, 'reps': 10, 'weight': 20,
      'muscles': ['Quads (Primary)', 'Glutes', 'Hip Flexors'],
      'tips': ['Rear foot elevated', 'Front shin stays vertical', 'Drive through front heel'],
      'restSeconds': 75,
      'icon': 'directions_run',
    },
    {
      'title': 'Leg Curl',
      'category': 'Legs',
      'duration': '25 min',
      'tag': 'Isolation',
      'sub': 'Hamstrings · Knee Flexion',
      'sets': 3, 'reps': 12, 'weight': 40,
      'muscles': ['Hamstrings (Primary)', 'Glutes'],
      'tips': ['Full range of motion', 'Pause at peak contraction', 'Slow on the way down'],
      'restSeconds': 60,
      'icon': 'fitness_center',
    },
    // ── Core ──
    {
      'title': 'Plank',
      'category': 'Core',
      'duration': '15 min',
      'tag': 'Stability',
      'sub': 'Deep Core · Anti-Rotation',
      'sets': 3, 'reps': 1, 'weight': 0,
      'muscles': ['Transverse Abdominis (Primary)', 'Obliques', 'Glutes'],
      'tips': ['Neutral spine', 'Squeeze glutes and core', 'Breathe steadily'],
      'restSeconds': 60,
      'icon': 'accessibility_new',
    },
    {
      'title': 'Dead Bug',
      'category': 'Core',
      'duration': '15 min',
      'tag': 'Corrective',
      'sub': 'Deep Core · Coordination',
      'sets': 3, 'reps': 10, 'weight': 0,
      'muscles': ['Deep Core (Primary)', 'Hip Flexors'],
      'tips': ['Lower back pressed to floor', 'Breathe out as you extend', 'Move slowly'],
      'restSeconds': 45,
      'icon': 'accessibility_new',
    },
    {
      'title': 'Russian Twist',
      'category': 'Core',
      'duration': '20 min',
      'tag': 'Rotation',
      'sub': 'Obliques · Rotational Power',
      'sets': 3, 'reps': 20, 'weight': 8,
      'muscles': ['Obliques (Primary)', 'Rectus Abdominis'],
      'tips': ['Lean back 45°', 'Keep feet off the floor', 'Touch weight to each side'],
      'restSeconds': 45,
      'icon': 'rotate_right',
    },
    {
      'title': 'Hanging Knee Raise',
      'category': 'Core',
      'duration': '20 min',
      'tag': 'Strength',
      'sub': 'Lower Abs · Hip Flexors',
      'sets': 3, 'reps': 12, 'weight': 0,
      'muscles': ['Lower Abs (Primary)', 'Hip Flexors'],
      'tips': ['Don\'t swing', 'Posterior pelvic tilt at top', 'Control the descent'],
      'restSeconds': 60,
      'icon': 'arrow_upward',
    },
    // ── Flexibility ──
    {
      'title': 'Hip Flexor Stretch',
      'category': 'Flexibility',
      'duration': '10 min',
      'tag': 'Restorative',
      'sub': 'Hip Flexors · Psoas',
      'sets': 2, 'reps': 1, 'weight': 0,
      'muscles': ['Hip Flexors (Primary)', 'Psoas', 'Quads'],
      'tips': ['90° front knee angle', 'Tuck pelvis under', 'Hold 30–60 seconds each side'],
      'restSeconds': 30,
      'icon': 'self_improvement',
    },
    {
      'title': 'Thoracic Rotation',
      'category': 'Flexibility',
      'duration': '10 min',
      'tag': 'Mobility',
      'sub': 'Upper Back · Spine',
      'sets': 2, 'reps': 10, 'weight': 0,
      'muscles': ['Thoracic Spine (Primary)', 'Rotator Cuff'],
      'tips': ['Move from mid-back, not lower', 'Keep hips still', 'Breathe through each rep'],
      'restSeconds': 30,
      'icon': 'rotate_right',
    },
    {
      'title': 'Pigeon Pose',
      'category': 'Flexibility',
      'duration': '12 min',
      'tag': 'Restorative',
      'sub': 'Glutes · Piriformis · Hip',
      'sets': 2, 'reps': 1, 'weight': 0,
      'muscles': ['Glutes (Primary)', 'Piriformis', 'Hip External Rotators'],
      'tips': ['Square hips to the mat', 'Fold forward to deepen', 'Hold 60–90 seconds'],
      'restSeconds': 30,
      'icon': 'self_improvement',
    },
    {
      'title': 'Hamstring Hold',
      'category': 'Flexibility',
      'duration': '10 min',
      'tag': 'Lengthening',
      'sub': 'Hamstrings · Lower Back',
      'sets': 2, 'reps': 1, 'weight': 0,
      'muscles': ['Hamstrings (Primary)', 'Calves'],
      'tips': ['Soft bend in standing knee', 'Flex foot of raised leg', 'Hold 45 seconds'],
      'restSeconds': 30,
      'icon': 'self_improvement',
    },
    {
      'title': 'Child\'s Pose',
      'category': 'Flexibility',
      'duration': '8 min',
      'tag': 'Recovery',
      'sub': 'Spine · Hips · Shoulders',
      'sets': 1, 'reps': 1, 'weight': 0,
      'muscles': ['Lats (Primary)', 'Thoracic Spine', 'Hips'],
      'tips': ['Arms extended fully', 'Sink hips to heels', 'Breathe into the lower back'],
      'restSeconds': 0,
      'icon': 'bedtime_outlined',
    },
  ];

  List<Map<String, dynamic>> get _filteredExercises {
    if (_selectedCategory == 0) return _exercises;
    final cat = _categories[_selectedCategory];
    return _exercises.where((e) => e['category'] == cat).toList();
  }

  IconData _iconForExercise(Map<String, dynamic> e) {
    final s = e['icon'] as String;
    switch (s) {
      case 'sync_alt': return Icons.sync_alt;
      case 'swap_horiz': return Icons.swap_horiz;
      case 'rotate_right': return Icons.rotate_right;
      case 'arrow_upward': return Icons.arrow_upward;
      case 'arrow_downward': return Icons.arrow_downward;
      case 'directions_run': return Icons.directions_run;
      case 'accessibility_new': return Icons.accessibility_new;
      case 'self_improvement': return Icons.self_improvement;
      case 'bedtime_outlined': return Icons.bedtime_outlined;
      default: return Icons.fitness_center;
    }
  }

  void _openExercise(Map<String, dynamic> exercise) {
    Navigator.push(context, AppRoute(page: ExerciseDetailScreen(exercise: exercise)));
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _currentProgramCard(),
                    const SizedBox(height: 16),
                    _dailyRitualCard(),
                    const SizedBox(height: 22),
                    _trainingSplit(),
                    const SizedBox(height: 22),
                    _targetFocus(),
                    const SizedBox(height: 22),
                    _newAndNotable(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _bottomNav(bottomPadding),
          ],
        ),
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, AppRoute(page: const ProfileScreen())),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primaryContainer,
              border: Border.all(color: _primary.withValues(alpha: 0.3), width: 1.5),
            ),
            child: const Icon(Icons.person, color: _primary, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Workouts',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _onSurface,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Menu', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
              backgroundColor: _primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              duration: const Duration(seconds: 1),
            ),
          ),
          child: const Icon(Icons.menu, color: _onSurface, size: 24),
        ),
      ],
    );
  }

  // ─── Current Program ───────────────────────────────────────────────────────

  Widget _currentProgramCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E6451), Color(0xFF3A4D3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.spa, color: Color(0xFFBFDAC1), size: 16),
              const SizedBox(width: 6),
              Text(
                'Current Program',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFFBFDAC1),
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Week 2 of 4',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 11, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            UserPrefs.programName(_intention),
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            UserPrefs.intentionMessage(_intention),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.78),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: 0.45,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFBFDAC1)),
                    minHeight: 5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '45%',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Daily Ritual ──────────────────────────────────────────────────────────

  Widget _dailyRitualCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _outline),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child:
                const Icon(Icons.wb_sunny_outlined, color: _primary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Ritual',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 11, color: _secondary),
                ),
                const SizedBox(height: 2),
                Text(
                  _suggestedWorkouts.isNotEmpty
                      ? _suggestedWorkouts.first['name']!
                      : 'Morning Flow Session',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _chip(_suggestedWorkouts.isNotEmpty ? _suggestedWorkouts.first['duration']! : '30 min'),
                    const SizedBox(width: 6),
                    _chip(_activities.isNotEmpty ? _activities.first : 'Full Body'),
                    const SizedBox(width: 6),
                    _chip(_suggestedWorkouts.isNotEmpty ? _suggestedWorkouts.first['intensity']! : 'Moderate', green: true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _openExercise(_exercises.first),
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: _primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Training Split ────────────────────────────────────────────────────────

  Widget _trainingSplit() {
    final splits = [
      {'label': 'Push', 'icon': Icons.fitness_center},
      {'label': 'Pull', 'icon': Icons.self_improvement},
      {'label': 'Legs', 'icon': Icons.directions_run},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Training Split',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(splits.length, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < 2 ? 10 : 0),
                child: GestureDetector(
                  onTap: () => _openExercise(_exercises.first),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _primaryContainer.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            splits[i]['icon'] as IconData,
                            color: _primary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          splits[i]['label'] as String,
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _onSurface,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Functional Focus',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10, color: _secondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ─── Target Focus ──────────────────────────────────────────────────────────

  Widget _targetFocus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Focus',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _onSurface,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final isSelected = _selectedCategory == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? _primary : _cardBg,
                    borderRadius: BorderRadius.circular(9999),
                    border:
                        Border.all(color: isSelected ? _primary : _outline),
                  ),
                  child: Text(
                    _categories[i],
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : _secondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── New & Notable ─────────────────────────────────────────────────────────

  Widget _newAndNotable() {
    final workouts = _filteredExercises;
    final label = _selectedCategory == 0 ? 'All Exercises' : _categories[_selectedCategory];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _onSurface,
              ),
            ),
            Text(
              '${workouts.length} exercises',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: _secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...workouts.map(
          (w) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => _openExercise(w),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _outline),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _primaryContainer.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(_iconForExercise(w), color: _primary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            w['title'] as String,
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _onSurface,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _chip(w['duration'] as String),
                              const SizedBox(width: 6),
                              _chip(w['tag'] as String),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            w['sub'] as String,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 12, color: _secondary),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${w['sets']}×${w['reps']}',
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _primary,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: _secondary, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Bottom Nav ────────────────────────────────────────────────────────────

  Widget _bottomNav(double bottomPadding) {
    final items = [
      Icons.home_rounded,
      Icons.fitness_center,
      Icons.restaurant,
      Icons.insights,
      Icons.smart_toy_outlined,
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottomPadding),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border(top: BorderSide(color: _outline, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isActive = _currentNavIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => _currentNavIndex = index);
              if (index == 0) {
                Navigator.pop(context);
              } else if (index == 1) {
                Navigator.pushReplacement(
                    context, AppRoute(page: const NutritionHubScreen(), reverse: true));
              } else if (index == 2) {
                // already on Workout
              } else if (index == 3) {
                Navigator.pushReplacement(
                    context,
                    AppRoute(page: const ProgressAnalyticsScreen()));
              } else if (index == 4) {
                Navigator.pushReplacement(
                    context, AppRoute(page: const AiCoachScreen()));
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isActive ? _primaryContainer : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Icon(
                items[index],
                color: isActive ? _primary : _secondary,
                size: 22,
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── Helper ────────────────────────────────────────────────────────────────

  Widget _chip(String label, {bool green = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: green
            ? _primaryContainer.withValues(alpha: 0.45)
            : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          color: green ? _primary : _secondary,
        ),
      ),
    );
  }
}
