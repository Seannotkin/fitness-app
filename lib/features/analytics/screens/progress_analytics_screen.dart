import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../ai_coach/screens/ai_coach_screen.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../workout/screens/workout_library_screen.dart';
import '../../../core/widgets/side_menu.dart';

class ProgressAnalyticsScreen extends StatefulWidget {
  const ProgressAnalyticsScreen({super.key});

  @override
  State<ProgressAnalyticsScreen> createState() =>
      _ProgressAnalyticsScreenState();
}

class _ProgressAnalyticsScreenState extends State<ProgressAnalyticsScreen> {
  int _currentNavIndex = 3;
  int _selectedPeriod = 0; // 0=W, 1=M, 2=3M, 3=1Y

  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFCFE3D4);
  static const _textPrimary = Color(0xFF303333);
  static const _textSecondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);
  static const _surfaceVariant = Color(0xFFE8F0EA);

  // Day data: 0=rest, 1=active, 2=recovery
  final List<Map<String, dynamic>> _weekDays = [
    {'label': 'MON', 'state': 1},
    {'label': 'TUE', 'state': 1},
    {'label': 'WED', 'state': 1},
    {'label': 'THU', 'state': 1},
    {'label': 'FRI', 'state': 1},
    {'label': 'SAT', 'state': 2},
    {'label': 'SUN', 'state': 0},
  ];

  final List<Map<String, dynamic>> _bodyStats = [
    {'period': 'W', 'weight': '72.0', 'fat': '14.2', 'lean': '61.8'},
    {'period': 'M', 'weight': '72.4', 'fat': '14.5', 'lean': '61.9'},
    {'period': '3M', 'weight': '73.8', 'fat': '15.1', 'lean': '62.6'},
    {'period': '1Y', 'weight': '76.2', 'fat': '16.3', 'lean': '63.8'},
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final stats = _bodyStats[_selectedPeriod];

    return Scaffold(
      backgroundColor: _bg,
      endDrawer: const SideMenu(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 24),
                    _weeklyRhythm(),
                    const SizedBox(height: 20),
                    _recoveryState(),
                    const SizedBox(height: 20),
                    _bodyEquilibrium(stats),
                    const SizedBox(height: 20),
                    _strengthLongevity(),
                    const SizedBox(height: 20),
                    _pathAhead(),
                    const SizedBox(height: 20),
                    _smallVictories(),
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

  // ── HEADER ──────────────────────────────────────────────────────────────────

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
              border: Border.all(
                  color: _primary.withValues(alpha: 0.3), width: 1.5),
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
                'Progress',
                style: GoogleFonts.manrope(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  letterSpacing: -0.34,
                ),
              ),
              Text(
                'Your Progress, Held Gently',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: _textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openEndDrawer(),
            child: const Icon(Icons.menu, color: _textSecondary, size: 24),
          ),
        ),
      ],
    );
  }

  // ── WEEKLY RHYTHM ────────────────────────────────────────────────────────────

  Widget _weeklyRhythm() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Consistency Flow',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Weekly Rhythm',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _primaryContainer,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded,
                        color: _primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '85% Active',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _weekDays.map((day) {
              final state = day['state'] as int;
              return _dayCircle(day['label'] as String, state);
            }).toList(),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _legendDot(_primary, 'Active'),
              const SizedBox(width: 14),
              _legendDot(const Color(0xFF4DB6AC), 'Recovery'),
              const SizedBox(width: 14),
              _legendDot(_outline, 'Rest'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayCircle(String label, int state) {
    Color bg;
    Color iconColor;
    IconData icon;
    if (state == 1) {
      bg = _primary;
      iconColor = Colors.white;
      icon = Icons.check_rounded;
    } else if (state == 2) {
      bg = const Color(0xFF4DB6AC);
      iconColor = Colors.white;
      icon = Icons.spa_outlined;
    } else {
      bg = _surfaceVariant;
      iconColor = _outline;
      icon = Icons.remove_rounded;
    }

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: state == 0 ? const Color(0xFFB0B2B2) : _textSecondary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            color: _textSecondary,
          ),
        ),
      ],
    );
  }

  // ── RECOVERY STATE ───────────────────────────────────────────────────────────

  Widget _recoveryState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recovery State',
          style: GoogleFonts.manrope(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
            letterSpacing: -0.34,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _recoveryCard(
              icon: Icons.monitor_heart_outlined,
              iconColor: const Color(0xFF9B5E82),
              iconBg: const Color(0xFFF2DFF0),
              label: 'HRV Balance',
              value: '64',
              unit: 'ms',
              status: 'Optimal',
              statusColor: const Color(0xFF4E6451),
              detail: 'Ready for high-intensity movement today',
            )),
            const SizedBox(width: 12),
            Expanded(child: _recoveryCard(
              icon: Icons.bedtime_outlined,
              iconColor: const Color(0xFF5B7EA6),
              iconBg: const Color(0xFFDCEAF5),
              label: 'Sleep Quality',
              value: '8h 12m',
              unit: '',
              status: 'Great',
              statusColor: const Color(0xFF4E6451),
              detail: 'Deep sleep: 2h achieved',
            )),
          ],
        ),
      ],
    );
  }

  Widget _recoveryCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    required String unit,
    required String status,
    required Color statusColor,
    required String detail,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
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
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 17),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: _textSecondary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit.isEmpty ? value : '$value $unit',
            style: GoogleFonts.manrope(
              fontSize: unit.isEmpty ? 18 : 22,
              fontWeight: FontWeight.w800,
              color: iconColor,
              letterSpacing: -0.44,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            detail,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: _textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ── BODY EQUILIBRIUM ─────────────────────────────────────────────────────────

  Widget _bodyEquilibrium(Map<String, dynamic> stats) {
    final periods = ['W', 'M', '3M', '1Y'];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Body Equilibrium',
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              // Period tabs
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: _surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: List.generate(periods.length, (i) {
                    final isActive = _selectedPeriod == i;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedPeriod = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isActive ? _primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          periods[i],
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isActive
                                ? Colors.white
                                : _textSecondary,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _bodyStatTile(
                  'Body Weight',
                  stats['weight'] as String,
                  'kg',
                  const Color(0xFF4E6451),
                  _primaryContainer,
                  Icons.monitor_weight_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _bodyStatTile(
                  'Body Fat',
                  stats['fat'] as String,
                  '%',
                  const Color(0xFF9B5E82),
                  const Color(0xFFF2DFF0),
                  Icons.percent_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _bodyStatTile(
                  'Lean Mass',
                  stats['lean'] as String,
                  'kg',
                  const Color(0xFF5B7EA6),
                  const Color(0xFFDCEAF5),
                  Icons.fitness_center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyStatTile(String label, String value, String unit,
      Color textColor, Color bgColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor, size: 16),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              color: textColor.withValues(alpha: 0.7),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              value,
              key: ValueKey(value),
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -0.36,
                height: 1.1,
              ),
            ),
          ),
          Text(
            unit,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: textColor.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }

  // ── STRENGTH LONGEVITY ───────────────────────────────────────────────────────

  Widget _strengthLongevity() {
    final groups = [
      {
        'label': 'Push',
        'sub': 'Chest / Shoulders',
        'gain': '+12% Vol',
        'value': 0.72,
        'color': const Color(0xFF4E6451),
        'bg': _primaryContainer,
        'icon': Icons.fitness_center,
      },
      {
        'label': 'Pull',
        'sub': 'Back / Biceps',
        'gain': '+8% Vol',
        'value': 0.55,
        'color': const Color(0xFF5B7EA6),
        'bg': const Color(0xFFDCEAF5),
        'icon': Icons.swap_vert_rounded,
      },
      {
        'label': 'Legs',
        'sub': 'Posterior / Quads',
        'gain': '+15% Vol',
        'value': 0.85,
        'color': const Color(0xFF9B5E82),
        'bg': const Color(0xFFF2DFF0),
        'icon': Icons.directions_walk_rounded,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Strength Longevity',
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            'Evolution · Volume gains this period',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: _textSecondary,
            ),
          ),
          const SizedBox(height: 18),
          ...groups.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _strengthBar(g),
              )),
        ],
      ),
    );
  }

  Widget _strengthBar(Map<String, dynamic> g) {
    final color = g['color'] as Color;
    final bg = g['bg'] as Color;
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(g['icon'] as IconData, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        g['label'] as String,
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                          letterSpacing: -0.26,
                        ),
                      ),
                      Text(
                        g['sub'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      g['gain'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: LinearProgressIndicator(
                  value: g['value'] as double,
                  backgroundColor: bg,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 7,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── PATH AHEAD ───────────────────────────────────────────────────────────────

  Widget _pathAhead() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primary,
            _primary.withValues(alpha: 0.80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Balanced Ascendant',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Path Ahead',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
              // Circular progress
              SizedBox(
                width: 72,
                height: 72,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.82,
                      strokeWidth: 6,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '82%',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.28,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Lv.08',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '4 mindful sessions away from reaching your next plateau.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _goalTask(
            '10,000 steps daily',
            '3/3 completed',
            true,
          ),
          const SizedBox(height: 8),
          _goalTask(
            'Yoga intensity high',
            '0/2 sessions',
            false,
          ),
        ],
      ),
    );
  }

  Widget _goalTask(String title, String sub, bool done) {
    return Row(
      children: [
        Icon(
          done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
          color: done ? Colors.white : Colors.white54,
          size: 20,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: done ? Colors.white : Colors.white70,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── SMALL VICTORIES ──────────────────────────────────────────────────────────

  Widget _smallVictories() {
    final victories = [
      {
        'title': 'Morning Flame',
        'desc': 'Completed 5 dawn workouts in a single week.',
        'icon': Icons.local_fire_department_rounded,
        'color': const Color(0xFFBF6A3A),
        'bg': const Color(0xFFFDE8D8),
        'locked': false,
      },
      {
        'title': 'The Sage',
        'desc': '10 consecutive days of mindful post-workout sessions.',
        'icon': Icons.self_improvement_rounded,
        'color': const Color(0xFF4E6451),
        'bg': _primaryContainer,
        'locked': false,
      },
      {
        'title': 'Quiet Power',
        'desc': 'Personal best in deadlifts at a lower heart rate.',
        'icon': Icons.auto_awesome_rounded,
        'color': const Color(0xFF5B7EA6),
        'bg': const Color(0xFFDCEAF5),
        'locked': false,
      },
      {
        'title': 'Unseen Growth',
        'desc': 'Keep going — this milestone is within reach.',
        'icon': Icons.lock_outline_rounded,
        'color': const Color(0xFFB0B2B2),
        'bg': const Color(0xFFF0EFED),
        'locked': true,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Small Victories',
              style: GoogleFonts.manrope(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                letterSpacing: -0.34,
              ),
            ),
            Text(
              'Archive',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: _primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...victories.map((v) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _victoryCard(v),
            )),
      ],
    );
  }

  Widget _victoryCard(Map<String, dynamic> v) {
    final locked = v['locked'] as bool;
    final color = v['color'] as Color;
    final bg = v['bg'] as Color;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: locked ? const Color(0xFFF7F6F5) : _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: locked ? _outline : color.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: locked
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              v['icon'] as IconData,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v['title'] as String,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: locked ? _textSecondary : _textPrimary,
                    letterSpacing: -0.28,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  v['desc'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: locked ? const Color(0xFFB0B2B2) : _textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (!locked)
            const Icon(Icons.star_rounded,
                color: Color(0xFFE6A817), size: 20),
        ],
      ),
    );
  }

  // ── BOTTOM NAV ───────────────────────────────────────────────────────────────

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
        border: const Border(top: BorderSide(color: _outline, width: 1)),
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
              if (index == 0) {
                Navigator.pop(context);
                return;
              }
              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  AppRoute(page: const WorkoutLibraryScreen(), instant: true),
                );
                return;
              }
              if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  AppRoute(page: const NutritionHubScreen(), instant: true),
                );
                return;
              }
              if (index == 4) {
                Navigator.pushReplacement(
                  context,
                  AppRoute(page: const AiCoachScreen(), instant: true),
                );
                return;
              }
              setState(() => _currentNavIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isActive ? _primaryContainer : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Icon(
                items[index],
                color: isActive ? _primary : const Color(0xFFADB5BD),
                size: 22,
              ),
            ),
          );
        }),
      ),
    );
  }
}
