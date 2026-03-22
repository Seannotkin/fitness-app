import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../home/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _selectedMission = 0;
  double _intensity = 7.5;

  final List<Map<String, dynamic>> _missions = [
    {
      'icon': Icons.bolt,
      'title': 'Hypertrophy',
      'subtitle': 'Maximize muscle fiber density',
    },
    {
      'icon': Icons.speed,
      'title': 'Peak Performance',
      'subtitle': 'Explosive power and speed',
    },
    {
      'icon': Icons.monitor_heart,
      'title': 'Metabolic Reset',
      'subtitle': 'Fat loss & metabolic health',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Icon(Icons.close, color: Color(0xFFE5E2E1), size: 22),
                ],
              ),
              const SizedBox(height: 36),

              // Step indicator
              Text(
                'STEP 02 OF 03  •  FITNESS ARCHITECTURE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00BFFF),
                  letterSpacing: 0.55,
                ),
              ),
              const SizedBox(height: 14),

              // Title
              Text(
                "Let's build your\nkinetic profile.",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE5E2E1),
                  letterSpacing: -0.68,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                'Our AI analyzes your biomechanics and goals to engineer the perfect program.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFFBCC8D1),
                  letterSpacing: 0.7,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),

              // Question
              Text(
                'What is your primary mission?',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE5E2E1),
                  letterSpacing: -0.36,
                ),
              ),
              const SizedBox(height: 16),

              // Mission cards
              ...List.generate(_missions.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _missionCard(index),
                );
              }),
              const SizedBox(height: 28),

              // Intensity Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activity Intensity',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFE5E2E1),
                    ),
                  ),
                  Text(
                    _intensity.toStringAsFixed(1),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8FD6FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 6,
                  thumbColor: const Color(0xFF8FD6FF),
                  activeTrackColor: const Color(0xFF8FD6FF),
                  inactiveTrackColor: const Color(0xFF353534),
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: const Color(0xFF8FD6FF).withOpacity(0.2),
                ),
                child: Slider(
                  value: _intensity,
                  min: 0,
                  max: 10,
                  onChanged: (value) => setState(() => _intensity = value),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sedentary',
                      style: GoogleFonts.inter(
                          fontSize: 11, color: const Color(0xFFBCC8D1))),
                  Text('Kinetic Master',
                      style: GoogleFonts.inter(
                          fontSize: 11, color: const Color(0xFFBCC8D1))),
                ],
              ),
              const SizedBox(height: 28),

              // AI Insight box
              _glassBox(),
              const SizedBox(height: 36),

              // CTA Button
              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8FD6FF), Color(0xFF00BFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      AppRoute(page: const HomeScreen()),
                    );
                  },
                  child: Text(
                    'CONTINUE MISSION',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF003549),
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _missionCard(int index) {
    final mission = _missions[index];
    final isSelected = _selectedMission == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedMission = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00BFFF).withOpacity(0.10)
              : const Color(0xFF1C1B1B),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFF8FD6FF).withOpacity(0.45), width: 1)
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF00BFFF).withOpacity(0.18)
                    : const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                mission['icon'] as IconData,
                color: isSelected
                    ? const Color(0xFF8FD6FF)
                    : const Color(0xFFBCC8D1),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mission['title'] as String,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF8FD6FF)
                          : const Color(0xFFE5E2E1),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    mission['subtitle'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFFBCC8D1),
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: Color(0xFF8FD6FF), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _glassBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF00BFFF).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF8FD6FF).withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFF8FD6FF), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Based on your selection, I'll prioritize high-intensity eccentric movements to accelerate muscle protein synthesis.",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFFBCC8D1),
                letterSpacing: 0.65,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
