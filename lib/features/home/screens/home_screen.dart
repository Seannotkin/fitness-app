import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../workout/screens/workout_library_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 14),
                    _energyCard(),
                    const SizedBox(height: 10),
                    _actionButtons(),
                    const SizedBox(height: 16),
                    _sectionHeader('Next Session', 'View Schedule'),
                    const SizedBox(height: 8),
                    _nextSessionCard(),
                    const SizedBox(height: 16),
                    _sectionHeader('Daily Milestones', null),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _milestoneCard(
                            Icons.directions_walk,
                            'Steps',
                            '8,432',
                            '10,000',
                            0.84,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _milestoneCard(
                            Icons.water_drop,
                            'Hydration',
                            '2.1L',
                            '3.0L',
                            0.70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            _bottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2A2A2A),
                border: Border.all(
                    color: const Color(0xFF8FD6FF).withOpacity(0.3), width: 1),
              ),
              child: const Icon(Icons.person, color: Color(0xFF8FD6FF), size: 17),
            ),
            const SizedBox(width: 10),
            Text(
              'NEON LAB',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8FD6FF),
                letterSpacing: -0.32,
              ),
            ),
          ],
        ),
        const Icon(Icons.settings_outlined, color: Color(0xFFBCC8D1), size: 20),
      ],
    );
  }

  Widget _energyCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1,482',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8FD6FF),
                      letterSpacing: -0.76,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'kcal remaining',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFFBCC8D1),
                      letterSpacing: 0.55,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFFF).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '62% TOTAL',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8FD6FF),
                    letterSpacing: 0.55,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: _macroStat(
                      'Protein', '142g', '82%', const Color(0xFF8FD6FF), 0.82)),
              const SizedBox(width: 10),
              Expanded(
                  child: _macroStat(
                      'Carbs', '95g', '45%', const Color(0xFFDFC1FF), 0.45)),
              const SizedBox(width: 10),
              Expanded(
                  child: _macroStat(
                      'Fats', '42g', '60%', const Color(0xFF00BFFF), 0.60)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macroStat(String label, String value, String percent, Color color,
      double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 10, color: const Color(0xFFBCC8D1), letterSpacing: 0.5),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE5E2E1),
              ),
            ),
            const SizedBox(width: 3),
            Text(
              percent,
              style: GoogleFonts.inter(
                  fontSize: 10, color: color, letterSpacing: 0.5),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF353534),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 3,
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(child: _gradientButton(Icons.fitness_center, 'Log Workout')),
        const SizedBox(width: 10),
        Expanded(child: _gradientButton(Icons.restaurant, 'Log Meal')),
      ],
    );
  }

  Widget _gradientButton(IconData icon, String label) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8FD6FF), Color(0xFF00BFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: const Color(0xFF003549), size: 16),
        label: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF003549),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String? action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE5E2E1),
            letterSpacing: -0.3,
          ),
        ),
        if (action != null)
          Text(
            action,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF8FD6FF),
              letterSpacing: 0.6,
            ),
          ),
      ],
    );
  }

  Widget _nextSessionCard() {
    return Container(
      height: 152,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1C1B1B),
            const Color(0xFF00BFFF).withOpacity(0.18)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _chip('45 mins'),
                    const SizedBox(width: 6),
                    _chip('12 exercises'),
                    const SizedBox(width: 6),
                    _chip('Advanced'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HYPER-PUMP: LEGS',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE5E2E1),
                        letterSpacing: -0.36,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Today  •  18:30',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF8FD6FF),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 14,
            bottom: 14,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF8FD6FF), Color(0xFF00BFFF)],
                ),
              ),
              child: const Icon(Icons.play_arrow,
                  color: Color(0xFF003549), size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
            fontSize: 10, color: const Color(0xFFBCC8D1), letterSpacing: 0.5),
      ),
    );
  }

  Widget _milestoneCard(IconData icon, String label, String value,
      String target, double progress) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF8FD6FF), size: 18),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFE5E2E1),
              letterSpacing: -0.4,
            ),
          ),
          Text(
            'of $target $label',
            style: GoogleFonts.inter(
                fontSize: 10,
                color: const Color(0xFFBCC8D1),
                letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF353534),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF8FD6FF)),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav() {
    final items = [
      Icons.home_rounded,
      Icons.fitness_center,
      Icons.restaurant,
      Icons.insights,
      Icons.smart_toy_outlined,
    ];

    final bottomPadding = MediaQuery.of(context).padding.bottom;

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
                setState(() => _currentNavIndex = index);
                if (index == 1) {
                  Navigator.push(
                    context,
                    AppRoute(page: const WorkoutLibraryScreen()),
                  ).then((_) => setState(() => _currentNavIndex = 0));
                }
              },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
