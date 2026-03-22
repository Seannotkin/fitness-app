import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../workout/screens/workout_library_screen.dart';

class NutritionHubScreen extends StatefulWidget {
  const NutritionHubScreen({super.key});

  @override
  State<NutritionHubScreen> createState() => _NutritionHubScreenState();
}

class _NutritionHubScreenState extends State<NutritionHubScreen> {
  int _currentNavIndex = 2;

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
                    _fuelStatusCard(),
                    const SizedBox(height: 24),
                    _macroSection(),
                    const SizedBox(height: 24),
                    _todaysProtocolSection(),
                    const SizedBox(height: 24),
                    _bioSyncSection(),
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
              'Nutrition',
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
              child:
                  const Icon(Icons.person, color: Color(0xFF8FD6FF), size: 17),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fuelStatusCard() {
    return Container(
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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF000000).withOpacity(0.55),
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
                        'Performance Mode',
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
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Color(0xFFDFC1FF), size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '82% Streak',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: const Color(0xFFDFC1FF),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '1,840',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE5E2E1),
                        letterSpacing: -1.04,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'kcal left',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xFF8FD6FF),
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Daily Fuel Status',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFFBCC8D1),
                    letterSpacing: 0.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _macroSection() {
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
            'Macro Split',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFE5E2E1),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          _macroBar('Protein', '142', '220', 'g', 142 / 220,
              const Color(0xFF8FD6FF)),
          const SizedBox(height: 12),
          _macroBar(
              'Carbs', '98', '245', 'g', 98 / 245, const Color(0xFFDFC1FF)),
          const SizedBox(height: 12),
          _macroBar(
              'Fats', '52', '65', 'g', 52 / 65, const Color(0xFFCB9EFF)),
        ],
      ),
    );
  }

  Widget _macroBar(String label, String current, String total, String unit,
      double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFBCC8D1),
                letterSpacing: 0.6,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: current,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  TextSpan(
                    text: '/$total$unit',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFFBCC8D1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF353534),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _todaysProtocolSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today's Protocol",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE5E2E1),
                letterSpacing: -0.36,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Log Meal',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF8FD6FF),
                  letterSpacing: 0.65,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _mealCard(
          time: '07:30',
          label: 'Breakfast',
          name: 'Avocado & Egg Protocol',
          kcal: '420 kcal',
          protein: '24g Protein',
          icon: Icons.breakfast_dining,
          iconColor: const Color(0xFF8FD6FF),
          verified: true,
        ),
        const SizedBox(height: 10),
        _mealCard(
          time: '13:00',
          label: 'Lunch',
          name: 'Kinetic Power Bowl',
          kcal: '610 kcal',
          protein: '48g Protein',
          icon: Icons.lunch_dining,
          iconColor: const Color(0xFFDFC1FF),
          verified: true,
        ),
        const SizedBox(height: 10),
        _mealCard(
          time: '',
          label: 'Dinner',
          name: 'Dinner Protocol Pending',
          kcal: '~520 kcal',
          protein: 'High Protein',
          icon: Icons.dinner_dining,
          iconColor: const Color(0xFF87929B),
          verified: false,
          pending: true,
        ),
      ],
    );
  }

  Widget _mealCard({
    required String time,
    required String label,
    required String name,
    required String kcal,
    required String protein,
    required IconData icon,
    required Color iconColor,
    required bool verified,
    bool pending = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
        border: pending
            ? Border.all(color: const Color(0xFF353534), width: 1)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
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
                        color: iconColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: iconColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    if (time.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: const Color(0xFFBCC8D1),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: pending
                        ? const Color(0xFF87929B)
                        : const Color(0xFFE5E2E1),
                    letterSpacing: -0.28,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$kcal  •  $protein',
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
          if (verified)
            const Icon(Icons.verified, color: Color(0xFF8FD6FF), size: 18)
          else
            const Icon(Icons.add_circle_outline,
                color: Color(0xFF87929B), size: 20),
        ],
      ),
    );
  }

  Widget _bioSyncSection() {
    final items = [
      {
        'name': 'Skyr Berry Recovery',
        'kcal': '180 kcal',
        'icon': Icons.icecream,
        'color': const Color(0xFFDFC1FF),
      },
      {
        'name': 'Atlantic Lean Protocol',
        'kcal': '340 kcal',
        'icon': Icons.set_meal,
        'color': const Color(0xFF8FD6FF),
      },
      {
        'name': 'Neuro-Fat Snack Mix',
        'kcal': '210 kcal',
        'icon': Icons.spa,
        'color': const Color(0xFFCB9EFF),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bio-Sync Suggestions',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE5E2E1),
                letterSpacing: -0.36,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF00BFFF).withOpacity(0.12),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'AI Curated',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8FD6FF),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1B1B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final item = items[i];
              final color = item['color'] as Color;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(item['icon'] as IconData,
                              color: color, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFE5E2E1),
                                  letterSpacing: -0.28,
                                ),
                              ),
                              Text(
                                item['kcal'] as String,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFFBCC8D1),
                                  letterSpacing: 0.55,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8FD6FF),
                                  Color(0xFF00BFFF)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Icon(Icons.add,
                                color: Color(0xFF003549), size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < items.length - 1)
                    Container(
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      color: const Color(0xFF353534),
                    ),
                ],
              );
            }),
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
