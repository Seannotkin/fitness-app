import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    const SizedBox(height: 24),
                    _energyCard(),
                    const SizedBox(height: 16),
                    _actionButtons(),
                    const SizedBox(height: 28),
                    _sectionHeader('Next Session', 'View Schedule'),
                    const SizedBox(height: 12),
                    _nextSessionCard(),
                    const SizedBox(height: 28),
                    _sectionHeader('Daily Milestones', null),
                    const SizedBox(height: 12),
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
                        const SizedBox(width: 12),
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
                    const SizedBox(height: 24),
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2A2A2A),
                border: Border.all(
                    color: const Color(0xFF8FD6FF).withOpacity(0.3), width: 1),
              ),
              child: const Icon(Icons.person,
                  color: Color(0xFF8FD6FF), size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'NEON LAB',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8FD6FF),
                letterSpacing: -0.36,
              ),
            ),
          ],
        ),
        const Icon(Icons.settings_outlined,
            color: Color(0xFFBCC8D1), size: 22),
      ],
    );
  }

  Widget _energyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(24),
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
                      fontSize: 52,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8FD6FF),
                      letterSpacing: -1.04,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'kcal remaining',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFFBCC8D1),
                      letterSpacing: 0.65,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFFF).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '62% TOTAL',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8FD6FF),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: _macroStat(
                      'Protein', '142g', '82%', const Color(0xFF8FD6FF), 0.82)),
              const SizedBox(width: 12),
              Expanded(
                  child: _macroStat(
                      'Carbs', '95g', '45%', const Color(0xFFDFC1FF), 0.45)),
              const SizedBox(width: 12),
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
              fontSize: 11, color: const Color(0xFFBCC8D1), letterSpacing: 0.55),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE5E2E1),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              percent,
              style:
                  GoogleFonts.inter(fontSize: 11, color: color, letterSpacing: 0.55),
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
            minHeight: 4,
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(child: _gradientButton(Icons.fitness_center, 'Log Workout')),
        const SizedBox(width: 12),
        Expanded(child: _gradientButton(Icons.restaurant, 'Log Meal')),
      ],
    );
  }

  Widget _gradientButton(IconData icon, String label) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8FD6FF), Color(0xFF00BFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: const Color(0xFF003549), size: 18),
        label: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13,
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
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE5E2E1),
            letterSpacing: -0.36,
          ),
        ),
        if (action != null)
          Text(
            action,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF8FD6FF),
              letterSpacing: 0.65,
            ),
          ),
      ],
    );
  }

  Widget _nextSessionCard() {
    return Container(
      height: 188,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Chips
                Row(
                  children: [
                    _chip('45 mins'),
                    const SizedBox(width: 8),
                    _chip('12 exercises'),
                    const SizedBox(width: 8),
                    _chip('Advanced'),
                  ],
                ),
                // Workout info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HYPER-PUMP: LEGS',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE5E2E1),
                        letterSpacing: -0.44,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Today  •  18:30',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF8FD6FF),
                        letterSpacing: 0.65,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Play button
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF8FD6FF), Color(0xFF00BFFF)],
                ),
              ),
              child: const Icon(Icons.play_arrow,
                  color: Color(0xFF003549), size: 26),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
            fontSize: 11,
            color: const Color(0xFFBCC8D1),
            letterSpacing: 0.55),
      ),
    );
  }

  Widget _milestoneCard(IconData icon, String label, String value,
      String target, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF8FD6FF), size: 22),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFE5E2E1),
              letterSpacing: -0.52,
            ),
          ),
          Text(
            'of $target $label',
            style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFFBCC8D1),
                letterSpacing: 0.55),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF353534),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8FD6FF)),
              minHeight: 6,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            onTap: () => setState(() => _currentNavIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                size: 22,
              ),
            ),
          );
        }),
      ),
    );
  }
}
