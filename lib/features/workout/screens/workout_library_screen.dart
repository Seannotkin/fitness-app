import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../../core/services/user_prefs.dart';
import '../../ai_coach/screens/ai_coach_screen.dart';
import '../../analytics/screens/progress_analytics_screen.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
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

  void _openExercise() {
    Navigator.push(context, AppRoute(page: const ExerciseDetailScreen()));
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Menu',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  backgroundColor: _primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  duration: const Duration(seconds: 1),
                ),
              ),
              child: const Icon(Icons.menu, color: _onSurface, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Sage & Solace',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _onSurface,
              ),
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryContainer,
          ),
          child: const Icon(Icons.person, color: _primary, size: 20),
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
            onTap: _openExercise,
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
                  onTap: _openExercise,
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
    const categories = [
      'Chest',
      'Legs  ·  14 Routines',
      'Core',
      'Back',
      'Upper Body',
      'Foundational',
    ];

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
            itemCount: categories.length,
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
                    categories[i],
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
    final workouts = [
      {
        'title': 'Golden Hour Power Sculpt',
        'duration': '45 min',
        'tag': 'Advanced Flow',
        'sub': 'Metabolic endurance',
        'icon': Icons.bolt,
      },
      {
        'title': 'Lunar Mobility Release',
        'duration': '15 min',
        'tag': 'Restorative',
        'sub': 'Tissue relaxation prep',
        'icon': Icons.bedtime_outlined,
      },
      {
        'title': 'Deep Core Foundations',
        'duration': '30 min',
        'tag': 'Stability',
        'sub': 'Pelvic floor activation',
        'icon': Icons.accessibility_new,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New & Notable',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _onSurface,
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('All workouts',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  backgroundColor: _primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  duration: const Duration(seconds: 1),
                ),
              ),
              child: Text(
                'See all',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: _primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...workouts.map(
          (w) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: _openExercise,
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
                      child: Icon(w['icon'] as IconData,
                          color: _primary, size: 24),
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
                    const Icon(Icons.chevron_right,
                        color: _secondary, size: 20),
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
                    context, AppRoute(page: const NutritionHubScreen()));
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
