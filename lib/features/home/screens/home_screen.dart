import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../ai_coach/screens/ai_coach_screen.dart';
import '../../analytics/screens/progress_analytics_screen.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
import '../../workout/screens/workout_library_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../../core/services/user_prefs.dart';
import '../../../core/widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  int? _selectedMood;
  String _userName = 'Friend';
  int _intention = 0;
  int _activityLevel = 2;
  double _waterGoalL = 2.0;
  int _waterGlasses = 0;
  int _streak = 1;
  List<String> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final streak = await UserPrefs.checkAndUpdateStreak();
    final name = await UserPrefs.getName();
    final intention = await UserPrefs.getIntention();
    final waterGoalGlasses = await UserPrefs.getWaterGlasses();
    final waterToday = await UserPrefs.getWaterToday();
    final activities = await UserPrefs.getActivities();
    final activityLevel = await UserPrefs.getActivityLevel();
    final mood = await UserPrefs.getMoodToday();
    if (mounted) {
      setState(() {
        _userName = name;
        _intention = intention;
        _activityLevel = activityLevel;
        _waterGoalL = UserPrefs.waterLitres(waterGoalGlasses);
        _waterGlasses = waterToday;
        _streak = streak;
        _activities = activities;
        _selectedMood = mood;
      });
    }
  }

  String get _formattedDate {
    final now = DateTime.now();
    const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    const months = ['','January','February','March','April','May','June','July','August','September','October','November','December'];
    return '${days[now.weekday - 1]}, ${months[now.month]} ${now.day}';
  }

  String get _greetingPrefix {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String get _timeOfDayLabel {
    final h = DateTime.now().hour;
    if (h < 12) return 'this morning';
    if (h < 17) return 'this afternoon';
    return 'tonight';
  }

  String get _dailyQuote {
    const quotes = [
      '"Health is not just what you are eating. It is what you are thinking and saying."',
      '"Take care of your body. It\'s the only place you have to live."',
      '"The greatest wealth is health."',
      '"Movement is a medicine for creating change in a person\'s physical, emotional, and mental states."',
      '"Happiness is the highest form of health."',
      '"A healthy outside starts from the inside."',
      '"Your body hears everything your mind says. Stay positive."',
      '"Wellness is the complete integration of body, mind, and spirit."',
      '"Small steps every day lead to big changes over time."',
      '"Rest when you need to, but never quit."',
      '"Strength does not come from the body. It comes from the will."',
      '"The only bad workout is the one that didn\'t happen."',
      '"You don\'t have to be extreme. Just consistent."',
      '"Progress, not perfection."',
    ];
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return quotes[dayOfYear % quotes.length];
  }

  double get _waterConsumedL => _waterGlasses * 0.25;

  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _textPrimary = Color(0xFF303333);
  static const _textSecondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _bg,
      endDrawer: const SideMenu(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _dailyProgressCard(),
                    const SizedBox(height: 16),
                    _workoutCard(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _waterCard()),
                        const SizedBox(width: 12),
                        Expanded(child: _sleepCard()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _reflectiveMoment(),
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

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(AppRoute(page: const ProfileScreen())),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_greetingPrefix, $_userName',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formattedDate,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: _textSecondary,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _primaryContainer,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_fire_department_rounded,
                        color: _primary, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      '$_streak Day Streak · ${UserPrefs.intentionLabels[_intention.clamp(0,3)]}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _primary,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openEndDrawer(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _cardBg,
                shape: BoxShape.circle,
                border: Border.all(color: _outline),
              ),
              child: const Icon(Icons.menu_rounded, color: _textSecondary, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dailyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Progress',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 18),

          // Steps
          _notSyncedMetricRow(
            icon: Icons.directions_walk,
            iconBg: _primaryContainer,
            iconColor: _primary,
            label: 'Steps',
            hint: 'Connect device to track',
          ),

          const SizedBox(height: 16),
          Container(height: 0.5, color: _outline),
          const SizedBox(height: 16),

          // Activity Calories
          _notSyncedMetricRow(
            icon: Icons.local_fire_department,
            iconBg: const Color(0xFFFDE8D8),
            iconColor: const Color(0xFFBF6A3A),
            label: 'Active Calories',
            hint: 'Connect device to track',
          ),

          const SizedBox(height: 16),

          // Rest + HRV row
          Row(
            children: [
              Expanded(
                child: _miniMetric(
                  icon: Icons.bedtime_outlined,
                  iconColor: const Color(0xFF5B7EA6),
                  iconBg: const Color(0xFFDCEAF5),
                  label: 'Rest',
                  value: 'Not synced',
                  valueColor: _textSecondary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _miniMetric(
                  icon: Icons.monitor_heart_outlined,
                  iconColor: const Color(0xFF9B5E82),
                  iconBg: const Color(0xFFF2DFF0),
                  label: 'HRV',
                  value: 'Not synced',
                  valueColor: _textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniMetric({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outline, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: _textSecondary,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: valueColor,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _notSyncedMetricRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String hint,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: _textSecondary)),
              const SizedBox(height: 2),
              Text(
                'Not synced',
                style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700, color: _textSecondary),
              ),
              Text(hint, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: _textSecondary.withValues(alpha: 0.6))),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Device sync coming soon', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                backgroundColor: _primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: _outline),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Sync', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w600, color: _textSecondary)),
          ),
        ),
      ],
    );
  }

  Widget _workoutCard() {
    final workoutName = _activities.isNotEmpty
        ? '${_activities.first} Session'
        : 'Morning Mobility\n& Breathwork';
    final intensity = _activityLevel <= 1
        ? 'Beginner'
        : _activityLevel == 2
            ? 'Intermediate'
            : 'Advanced';
    final duration = _activityLevel <= 1 ? '15m' : _activityLevel == 2 ? '25m' : '35m';
    final iconData = _activities.isNotEmpty
        ? _workoutIcon(_activities.first)
        : Icons.self_improvement;
    final categoryLabel = _activities.isNotEmpty
        ? _activities.first
        : 'Mobility';

    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              gradient: LinearGradient(
                colors: [
                  _primary,
                  _primary.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, color: Colors.white, size: 36),
                const SizedBox(height: 6),
                Text(
                  categoryLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _primaryContainer,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      UserPrefs.intentionLabels[_intention.clamp(0, 3)],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: _primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    workoutName,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _textPrimary,
                      letterSpacing: -0.28,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: _textSecondary, size: 12),
                      const SizedBox(width: 3),
                      Text(duration, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: _textSecondary)),
                      const SizedBox(width: 8),
                      Container(width: 3, height: 3, decoration: const BoxDecoration(shape: BoxShape.circle, color: _textSecondary)),
                      const SizedBox(width: 8),
                      Text(intensity, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: _textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() => _currentNavIndex = 1);
                      Navigator.push(
                        context,
                        AppRoute(page: const WorkoutLibraryScreen()),
                      ).then((_) => setState(() => _currentNavIndex = 0));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: _primary,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Start Session',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _workoutIcon(String activity) {
    switch (activity.toLowerCase()) {
      case 'yoga': return Icons.self_improvement;
      case 'running': return Icons.directions_run;
      case 'swimming': return Icons.pool;
      case 'cycling': return Icons.pedal_bike;
      case 'strength':
      case 'weight training': return Icons.fitness_center;
      case 'pilates': return Icons.accessibility_new;
      case 'hiit': return Icons.local_fire_department;
      case 'meditation': return Icons.spa;
      default: return Icons.sports;
    }
  }

  Widget _waterCard() {
    final progress = _waterGoalL > 0 ? (_waterConsumedL / _waterGoalL).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EAF8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.water_drop_outlined,
                    color: Color(0xFF2E86C1), size: 18),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final val = await UserPrefs.addWater(-1);
                      setState(() => _waterGlasses = val);
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _bg,
                        shape: BoxShape.circle,
                        border: Border.all(color: _outline),
                      ),
                      child: const Icon(Icons.remove, size: 14, color: _textSecondary),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () async {
                      final val = await UserPrefs.addWater(1);
                      setState(() => _waterGlasses = val);
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E86C1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Water',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: _textSecondary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _waterConsumedL.toStringAsFixed(1),
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2E86C1),
                  letterSpacing: -0.48,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  '/ ${_waterGoalL.toStringAsFixed(1)}L',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: _textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFD6EAF8),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF2E86C1)),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$_waterGlasses of ${(_waterGoalL / 0.25).round()} glasses',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: _textSecondary,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sleepCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bedtime_outlined,
                color: Color(0xFF6A1B9A), size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            'Sleep',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: _textSecondary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Not synced',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _textSecondary,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: const LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Color(0xFFEDE7F6),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6A1B9A)),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Connect device to track',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: _textSecondary,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reflectiveMoment() {
    final moods = [
      {'label': 'Energized', 'icon': Icons.bolt},
      {'label': 'Calm', 'icon': Icons.spa_outlined},
      {'label': 'Tired', 'icon': Icons.nights_stay_outlined},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _primaryContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _primary.withValues(alpha: 0.15), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_quote_rounded,
                  color: _primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Reflective Moment',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                  letterSpacing: -0.28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _dailyQuote,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: _textPrimary,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'How are you feeling $_timeOfDayLabel?',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _textSecondary,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(moods.length, (i) {
              final isSelected = _selectedMood == i;
              return Padding(
                padding: EdgeInsets.only(right: i < moods.length - 1 ? 8 : 0),
                child: GestureDetector(
                  onTap: () async {
                    final newMood = isSelected ? null : i;
                    setState(() => _selectedMood = newMood);
                    await UserPrefs.saveMood(newMood);
                    if (mounted && newMood != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Feeling ${moods[newMood]['label']} — noted!',
                            style: GoogleFonts.plusJakartaSans(fontSize: 13),
                          ),
                          backgroundColor: _primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? _primary : _cardBg,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: isSelected
                            ? _primary
                            : _primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          moods[i]['icon'] as IconData,
                          color: isSelected ? Colors.white : _primary,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          moods[i]['label'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : _primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav(double bottomPadding) {
    const labels = ['Home', 'Workout', 'Nutrition', 'Progress', 'Sage'];
    final icons = [
      Icons.home_rounded,
      Icons.fitness_center,
      Icons.restaurant,
      Icons.insights,
      Icons.smart_toy_outlined,
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8 + bottomPadding),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border(
          top: BorderSide(color: _outline, width: 1),
        ),
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
        children: List.generate(icons.length, (index) {
          final isActive = _currentNavIndex == index;
          return GestureDetector(
            onTap: () {
              if (index == 0) return; // already on Home
              setState(() => _currentNavIndex = index);
              Widget screen;
              switch (index) {
                case 1: screen = const WorkoutLibraryScreen(); break;
                case 2: screen = const NutritionHubScreen(); break;
                case 3: screen = const ProgressAnalyticsScreen(); break;
                case 4: screen = const AiCoachScreen(); break;
                default: return;
              }
              Navigator.push(context, AppRoute(page: screen))
                  .then((_) => setState(() => _currentNavIndex = 0));
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icons[index],
                    color: isActive ? _primary : const Color(0xFFADB5BD),
                    size: 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    labels[index],
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive ? _primary : const Color(0xFFADB5BD),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
