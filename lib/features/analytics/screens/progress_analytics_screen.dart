import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
import '../../workout/screens/workout_library_screen.dart';

class ProgressAnalyticsScreen extends StatefulWidget {
  const ProgressAnalyticsScreen({super.key});

  @override
  State<ProgressAnalyticsScreen> createState() =>
      _ProgressAnalyticsScreenState();
}

class _ProgressAnalyticsScreenState extends State<ProgressAnalyticsScreen> {
  int _currentNavIndex = 3;
  int _selectedPeriod = 0; // 0=Week, 1=Month, 2=Year

  final List<Map<String, dynamic>> _weekData = [
    {'day': 'MON', 'value': 0.55, 'label': '18T'},
    {'day': 'TUE', 'value': 0.80, 'label': '26T'},
    {'day': 'WED', 'value': 0.35, 'label': '11T'},
    {'day': 'THU', 'value': 1.0, 'label': '34T'},
    {'day': 'FRI', 'value': 0.70, 'label': '23T'},
    {'day': 'SAT', 'value': 0.20, 'label': '6T'},
    {'day': 'SUN', 'value': 0.0, 'label': 'Rest'},
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _periodSelector(),
                    const SizedBox(height: 20),
                    _volumeCard(),
                    const SizedBox(height: 24),
                    _bodyCompositionSection(),
                    const SizedBox(height: 24),
                    _achievementsSection(),
                    const SizedBox(height: 24),
                    _liftDistributionSection(),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NEON LAB',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8FD6FF),
                letterSpacing: -0.36,
              ),
            ),
            Text(
              'Progress Analytics',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFFBCC8D1),
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.settings_outlined,
                color: Color(0xFFBCC8D1), size: 20),
            const SizedBox(width: 12),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2A2A2A),
                border: Border.all(
                    color: const Color(0xFF8FD6FF).withOpacity(0.3), width: 1),
              ),
              child: const Icon(Icons.person,
                  color: Color(0xFF8FD6FF), size: 17),
            ),
          ],
        ),
      ],
    );
  }

  Widget _periodSelector() {
    final periods = ['Week', 'Month', 'Year'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(periods.length, (i) {
          final isActive = _selectedPeriod == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedPeriod = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF00BFFF).withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: isActive
                      ? Border.all(
                          color: const Color(0xFF8FD6FF).withOpacity(0.3),
                          width: 1)
                      : null,
                ),
                child: Text(
                  periods[i],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? const Color(0xFF8FD6FF)
                        : const Color(0xFF87929B),
                    letterSpacing: 0.65,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _volumeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cumulative Volume',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFFBCC8D1),
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '142.8',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF8FD6FF),
                          letterSpacing: -0.72,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Tons',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFFBCC8D1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFFF).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up,
                        color: Color(0xFF8FD6FF), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '+12% vs last week',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8FD6FF),
                        letterSpacing: 0.55,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _barChart(),
        ],
      ),
    );
  }

  Widget _barChart() {
    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _weekData.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          final value = item['value'] as double;
          final isPeak = i == 3;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isPeak) ...[
                    Text(
                      item['label'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8FD6FF),
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    height: value == 0 ? 4 : 100 * value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: isPeak
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF8FD6FF),
                                Color(0xFF00BFFF)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            )
                          : LinearGradient(
                              colors: [
                                const Color(0xFF8FD6FF).withOpacity(0.25),
                                const Color(0xFF8FD6FF).withOpacity(0.45),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['day'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: isPeak
                          ? const Color(0xFF8FD6FF)
                          : const Color(0xFF87929B),
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _bodyCompositionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Body Composition',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE5E2E1),
            letterSpacing: -0.36,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: Icons.monitor_weight_outlined,
                iconColor: const Color(0xFF8FD6FF),
                label: 'Weight',
                value: '84.2',
                unit: 'kg',
                change: '-0.4 kg',
                positive: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                icon: Icons.percent,
                iconColor: const Color(0xFFDFC1FF),
                label: 'Body Fat',
                value: '14.2',
                unit: '%',
                change: '-0.6%',
                positive: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String unit,
    required String change,
    required bool positive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFFBCC8D1),
              letterSpacing: 0.55,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE5E2E1),
                  letterSpacing: -0.56,
                  height: 1,
                ),
              ),
              const SizedBox(width: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFFBCC8D1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  positive ? Icons.arrow_downward : Icons.arrow_upward,
                  color: iconColor,
                  size: 10,
                ),
                const SizedBox(width: 3),
                Text(
                  change,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: iconColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _achievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE5E2E1),
            letterSpacing: -0.36,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _achievementBadge(
                icon: Icons.workspace_premium,
                iconColor: const Color(0xFFFFD700),
                bgColor: const Color(0xFFFFD700),
                title: 'Iron Giant',
                subtitle: '100T Lifted',
                locked: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _achievementBadge(
                icon: Icons.bolt,
                iconColor: const Color(0xFF8FD6FF),
                bgColor: const Color(0xFF8FD6FF),
                title: 'Streak King',
                subtitle: '15 Day Streak',
                locked: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _achievementBadge(
                icon: Icons.lock_outline,
                iconColor: const Color(0xFF87929B),
                bgColor: const Color(0xFF87929B),
                title: 'Level 20',
                subtitle: 'LOCKED',
                locked: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _achievementBadge({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required bool locked,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: locked
              ? const Color(0xFF2A2A2A)
              : bgColor.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor.withOpacity(locked ? 0.06 : 0.14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: locked
                  ? const Color(0xFF87929B)
                  : const Color(0xFFE5E2E1),
              letterSpacing: -0.24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: locked ? const Color(0xFF3D4850) : iconColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _liftDistributionSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lift Distribution',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFE5E2E1),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          _liftBar(
            Icons.fitness_center,
            'Compound Lifts',
            '65% of volume',
            0.65,
            const Color(0xFF8FD6FF),
          ),
          const SizedBox(height: 14),
          _liftBar(
            Icons.linear_scale,
            'Isolation Lifts',
            '35% of volume',
            0.35,
            const Color(0xFFDFC1FF),
          ),
        ],
      ),
    );
  }

  Widget _liftBar(IconData icon, String label, String sub, double value,
      Color color) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 17),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFE5E2E1),
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    sub,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 0.55,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: const Color(0xFF353534),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomNav(double bottomPadding) {
    final items = [
      Icons.home_rounded,
      Icons.fitness_center,
      Icons.restaurant,
      Icons.insights,
      Icons.smart_toy_outlined,
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8 + bottomPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B).withOpacity(0.95),
        border: Border(
          top: BorderSide(
              color: const Color(0xFF3D4850).withOpacity(0.3), width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isActive = _currentNavIndex == index;
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.popUntil(context, (route) => route.isFirst);
                return;
              }
              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  AppRoute(page: const WorkoutLibraryScreen()),
                );
                return;
              }
              if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  AppRoute(page: const NutritionHubScreen()),
                );
                return;
              }
              setState(() => _currentNavIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF00BFFF).withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Icon(
                items[index],
                color: isActive
                    ? const Color(0xFF8FD6FF)
                    : const Color(0xFF87929B),
                size: 20,
              ),
            ),
          );
        }),
      ),
    );
  }
}
