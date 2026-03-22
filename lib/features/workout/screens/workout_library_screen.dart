import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutLibraryScreen extends StatefulWidget {
  const WorkoutLibraryScreen({super.key});

  @override
  State<WorkoutLibraryScreen> createState() => _WorkoutLibraryScreenState();
}

class _WorkoutLibraryScreenState extends State<WorkoutLibraryScreen> {
  int _currentNavIndex = 1;

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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _dailySessionCard(),
                    const SizedBox(height: 24),
                    _programsSection(),
                    const SizedBox(height: 24),
                    _metricsRow(),
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
              'Workout',
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

  Widget _dailySessionCard() {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2A3A), Color(0xFF0D4060), Color(0xFF00BFFF)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00BFFF).withOpacity(0.20),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Dark overlay gradient at bottom
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF000000).withOpacity(0.7),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date + program badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BFFF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                            color: const Color(0xFF8FD6FF).withOpacity(0.3),
                            width: 1),
                      ),
                      child: Text(
                        'WED, OCT 24',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8FD6FF),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        'Hypertrophy Advanced',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: const Color(0xFFBCC8D1),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Workout title
                Text(
                  'POSTERIOR CHAIN\nANNIHILATION',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFE5E2E1),
                    letterSpacing: -0.52,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),

                // Stats + button row
                Row(
                  children: [
                    // Stats
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            color: Color(0xFF8FD6FF), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '75 MIN',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF8FD6FF),
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Icon(Icons.local_fire_department,
                            color: Color(0xFFDFC1FF), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '850 KCAL',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFDFC1FF),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Start Session button
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8FD6FF), Color(0xFF00BFFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        'Start Session',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF003549),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _programsSection() {
    final programs = [
      {
        'badge': 'Strength',
        'badgeColor': const Color(0xFF8FD6FF),
        'title': 'Hypertrophy Max',
        'duration': '12W',
        'icon': Icons.fitness_center,
        'desc': 'Maximum muscle fiber recruitment for density gains.',
      },
      {
        'badge': 'Recovery',
        'badgeColor': const Color(0xFFDFC1FF),
        'title': 'Kinetic Flow',
        'duration': '4W',
        'icon': Icons.waves,
        'desc': 'Active recovery and mobility for peak performance.',
      },
      {
        'badge': 'Elite',
        'badgeColor': const Color(0xFFCB9EFF),
        'title': 'Iron Absolute',
        'duration': '16W',
        'icon': Icons.emoji_events,
        'desc': 'Elite-level programming for advanced athletes.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Training Programs',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE5E2E1),
                letterSpacing: -0.36,
              ),
            ),
            Text(
              'View All',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF8FD6FF),
                letterSpacing: 0.65,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...programs.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _programCard(p),
            )),
      ],
    );
  }

  Widget _programCard(Map<String, dynamic> p) {
    final badgeColor = p['badgeColor'] as Color;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00BFFF).withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(p['icon'] as IconData, color: badgeColor, size: 22),
          ),
          const SizedBox(width: 14),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        p['badge'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: badgeColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      p['duration'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFFBCC8D1),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  p['title'] as String,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFE5E2E1),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  p['desc'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFFBCC8D1),
                    letterSpacing: 0.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios,
              color: Color(0xFFBCC8D1), size: 14),
        ],
      ),
    );
  }

  Widget _metricsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: _metricItem('42.5 Tons', 'Weekly Volume',
                const Color(0xFF8FD6FF)),
          ),
          Container(
            width: 1,
            height: 36,
            color: const Color(0xFF353534),
          ),
          Expanded(
            child: _metricItem(
                '92 %', 'Rest Quality', const Color(0xFFDFC1FF)),
          ),
        ],
      ),
    );
  }

  Widget _metricItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: -0.44,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: const Color(0xFFBCC8D1),
            letterSpacing: 0.55,
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
                  Navigator.pop(context);
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
