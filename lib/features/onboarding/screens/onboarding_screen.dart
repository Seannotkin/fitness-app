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
  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _onSurface = Color(0xFF303333);
  static const _secondary = Color(0xFF5A605C);
  static const _outline = Color(0xFFE1E3E3);

  final PageController _pageController = PageController();
  int _page = 0;

  // Step 1
  final _nameController = TextEditingController();
  int _intention = 0;

  // Step 2
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double _bmr = 0;
  double _tdee = 0;
  bool _calculated = false;

  // Step 3
  int _activityLevel = 2;
  final Set<String> _selectedActivities = {'Yoga', 'Running'};

  // Step 4
  int _waterGlasses = 2;
  int _sleepQuality = 3;
  final Set<String> _dietaryFocus = {'Balanced'};

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBMR() {
    final age = int.tryParse(_ageController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;
    if (age > 0 && height > 0 && weight > 0) {
      final bmr = 10 * weight + 6.25 * height - 5 * age + 5;
      setState(() {
        _bmr = bmr;
        _tdee = bmr * 1.55;
        _calculated = true;
      });
    }
  }

  void _next() {
    if (_page < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      Navigator.of(context).pushReplacement(
        AppRoute(page: const HomeScreen()),
      );
    }
  }

  void _back() {
    if (_page > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _back,
                        child: const Icon(Icons.arrow_back,
                            color: _onSurface, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Your Journey',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: LinearProgressIndicator(
                      value: (_page + 1) / 5,
                      backgroundColor: _primaryContainer.withOpacity(0.35),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(_primary),
                      minHeight: 5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_page + 1} of 5',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12, color: _secondary),
                      ),
                      Text(
                        '${((_page + 1) / 5 * 100).round()}% Complete',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: _primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                  _buildStep4(),
                  _buildStep5(),
                ],
              ),
            ),
            // Bottom nav
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Row(
                children: [
                  if (_page > 0) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _back,
                        icon: const Icon(Icons.chevron_left, size: 18),
                        label: Text(
                          'Back',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _secondary,
                          side: const BorderSide(color: Color(0xFFB0B2B2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: _page > 0 ? 2 : 1,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_page == 4) ...[
                            const Icon(Icons.spa, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Enter Sanctuary',
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ] else ...[
                            Text(
                              'Continue',
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.chevron_right, size: 18),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Step 1: Welcome & Intention ───────────────────────────────────────────

  Widget _buildStep1() {
    final intentions = [
      {
        'icon': Icons.self_improvement,
        'title': 'Find Balance',
        'subtitle': 'Harmonize work, life, and rest.',
      },
      {
        'icon': Icons.bolt,
        'title': 'Build Strength',
        'subtitle': 'Get stronger, inside and out.',
      },
      {
        'icon': Icons.flash_on,
        'title': 'Increase Energy',
        'subtitle': 'Fuel your days with vitality.',
      },
      {
        'icon': Icons.bedtime,
        'title': 'Improve Sleep',
        'subtitle': 'Restorative nights for better days.',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Begin your path to\nintentional living.',
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _onSurface,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "We'll tailor your experience based on your current energy and aspirations.",
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _secondary, height: 1.55),
          ),
          const SizedBox(height: 24),
          Text(
            'What shall we call you?',
            style: GoogleFonts.manrope(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _onSurface),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _nameController,
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: _onSurface),
            decoration: InputDecoration(
              hintText: 'Your name',
              hintStyle: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFB0B2B2)),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your primary intention',
            style: GoogleFonts.manrope(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _onSurface),
          ),
          const SizedBox(height: 12),
          ...List.generate(intentions.length, (i) {
            final item = intentions[i];
            final selected = _intention == i;
            return GestureDetector(
              onTap: () => setState(() => _intention = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selected
                      ? _primaryContainer.withOpacity(0.38)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected ? _primary : _outline,
                    width: selected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: selected
                            ? _primaryContainer
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: selected ? _primary : _secondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selected ? _primary : _onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['subtitle'] as String,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 12, color: _secondary),
                          ),
                        ],
                      ),
                    ),
                    if (selected)
                      const Icon(Icons.check_circle,
                          color: _primary, size: 20),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAEFDE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote,
                    color: Color(0xFF655E51), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '"The journey of a thousand miles begins with a single step."',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF655E51),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Step 2: Physical Foundation ───────────────────────────────────────────

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Build your Physical\nBaseline',
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _onSurface,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understanding your body helps us create a plan that truly fits you.',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _secondary, height: 1.55),
          ),
          const SizedBox(height: 24),
          _labeledField('Age', 'Years', _ageController,
              TextInputType.number),
          const SizedBox(height: 14),
          _labeledField('Height', 'Centimeters', _heightController,
              TextInputType.number),
          const SizedBox(height: 14),
          _labeledField('Current Weight', 'Kilograms', _weightController,
              TextInputType.number),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _calculateBMR,
              style: OutlinedButton.styleFrom(
                foregroundColor: _primary,
                side: const BorderSide(color: _primary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Calculate',
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
          if (_calculated) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _primaryContainer.withOpacity(0.32),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _primaryContainer),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: _primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Live Physical Insight',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _insightRow('Resting BMR', '${_bmr.round()} kcal/day'),
                  const SizedBox(height: 8),
                  _insightRow(
                      'Active Burn (TDEE)', '${_tdee.round()} kcal/day'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _labeledField(String label, String hint,
      TextEditingController ctrl, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _onSurface),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          keyboardType: type,
          style:
              GoogleFonts.plusJakartaSans(fontSize: 15, color: _onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFB0B2B2)),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _insightRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 13, color: _secondary)),
        Text(value,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _primary,
            )),
      ],
    );
  }

  // ─── Step 3: Movement Habits ────────────────────────────────────────────────

  Widget _buildStep3() {
    const levels = [
      'Sedentary',
      'Lightly Active',
      'Moderately Active',
      'Athlete',
    ];
    const activities = [
      'Yoga',
      'Running',
      'Strength',
      'Swimming',
      'Cycling',
      'Hiking',
      'Pilates',
    ];
    const activityIcons = [
      Icons.self_improvement,
      Icons.directions_run,
      Icons.fitness_center,
      Icons.pool,
      Icons.directions_bike,
      Icons.terrain,
      Icons.sports_gymnastics,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Movement\nFoundation',
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _onSurface,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understanding your current movement helps us meet you where you are.',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _secondary, height: 1.55),
          ),
          const SizedBox(height: 24),
          Text(
            'How would you describe your current relationship with movement?',
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _onSurface),
          ),
          const SizedBox(height: 12),
          ...List.generate(levels.length, (i) {
            final selected = _activityLevel == i;
            return GestureDetector(
              onTap: () => setState(() => _activityLevel = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: selected
                      ? _primaryContainer.withOpacity(0.38)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected ? _primary : _outline,
                    width: selected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? _primary : const Color(0xFFB0B2B2),
                          width: 2,
                        ),
                        color: selected ? _primary : Colors.transparent,
                      ),
                      child: selected
                          ? const Center(
                              child: Icon(Icons.circle,
                                  color: Colors.white, size: 8))
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      levels[i],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: selected ? _primary : _onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Text(
            'Favorite rituals',
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _onSurface),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(activities.length, (i) {
              final active = _selectedActivities.contains(activities[i]);
              return GestureDetector(
                onTap: () => setState(() {
                  if (active) {
                    _selectedActivities.remove(activities[i]);
                  } else {
                    _selectedActivities.add(activities[i]);
                  }
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active
                        ? _primaryContainer.withOpacity(0.45)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(
                      color: active ? _primary : _outline,
                      width: active ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        activityIcons[i],
                        size: 16,
                        color: active ? _primary : _secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        activities[i],
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: active ? _primary : _secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _primaryContainer.withOpacity(0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '"Movement is not a chore, but a conversation with your body. By understanding your starting point, we can design a path that honors your energy levels."',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: _primary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Step 4: Nourishment & Habits ──────────────────────────────────────────

  Widget _buildStep4() {
    const waterOptions = ['2', '4', '6', '8+'];
    const sleepLabels = ['Tired', 'Groggy', 'Okay', 'Rested', 'Radiant'];
    const dietOptions = [
      'Plant-Based',
      'Gluten-Free',
      'High Protein',
      'No Sugar',
      'Intermittent Fasting',
      'Balanced',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nourishment\n& Habits',
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _onSurface,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'These habits shape your energy and recovery. Tell us about yours.',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _secondary, height: 1.55),
          ),
          const SizedBox(height: 24),
          // Hydration
          _sectionLabel(Icons.water_drop,
              'How many glasses of water do you drink daily?'),
          const SizedBox(height: 12),
          Row(
            children: List.generate(waterOptions.length, (i) {
              final selected = _waterGlasses == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _waterGlasses = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: EdgeInsets.only(right: i < 3 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: selected ? _primary : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected ? _primary : _outline,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        waterOptions[i],
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color:
                              selected ? Colors.white : _secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          // Sleep quality
          _sectionLabel(
              Icons.bedtime, 'How rested do you feel upon waking?'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(sleepLabels.length, (i) {
              final selected = _sleepQuality == i;
              return GestureDetector(
                onTap: () => setState(() => _sleepQuality = i),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: selected ? _primary : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? _primary : _outline,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: selected ? Colors.white : _secondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sleepLabels[i],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: selected ? _primary : _secondary,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          // Dietary focus
          _sectionLabel(Icons.restaurant, 'Dietary focus'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: dietOptions.map((opt) {
              final active = _dietaryFocus.contains(opt);
              return GestureDetector(
                onTap: () => setState(() {
                  if (active) {
                    _dietaryFocus.remove(opt);
                  } else {
                    _dietaryFocus.add(opt);
                  }
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active
                        ? _primaryContainer.withOpacity(0.45)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(
                      color: active ? _primary : _outline,
                      width: active ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    opt,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: active ? _primary : _secondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: _primary, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _onSurface),
          ),
        ),
      ],
    );
  }

  // ─── Step 5: Personalized Path ─────────────────────────────────────────────

  Widget _buildStep5() {
    final tdee = _tdee > 0 ? _tdee.round() : 2450;
    final protein = _tdee > 0 ? (_tdee * 0.075).round() : 185;
    final carbs = _tdee > 0 ? (_tdee * 0.098).round() : 240;
    final fats = _tdee > 0 ? (_tdee * 0.031).round() : 75;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Calculated\nFoundation',
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: _onSurface,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your personalized metabolic profile and wellness plan, crafted just for you.',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: _secondary, height: 1.55),
          ),
          const SizedBox(height: 16),
          // Optimized badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome,
                    color: _primary, size: 14),
                const SizedBox(width: 6),
                Text(
                  'Optimized',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // Nutrition card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _outline),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Energy (TDEE)',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12, color: _secondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$tdee kcal',
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: _primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _primaryContainer.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.local_fire_department,
                          color: _primary, size: 22),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _macroTile('Proteins', '${protein}g',
                          'Foundational Repair', Icons.fitness_center),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _macroTile('Carbohydrates', '${carbs}g',
                          'Daily Vitality', Icons.grain),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _macroTile('Healthy Fats', '${fats}g',
                          'Hormonal Balance', Icons.water_drop),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _macroTile(
                          'Hydration', '2.5L', 'Cellular Flow', Icons.opacity),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // Recommended program card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E6451), Color(0xFF3A4D3C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.spa,
                        color: Color(0xFFBFDAC1), size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Recommended Program',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFFBFDAC1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'The Morning Stillness',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '12-Week Foundation Program',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.72),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _programChip('Beginner Friendly'),
                    _programChip('45 min/day'),
                    _programChip('4 days/week'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Low-impact program emphasizing functional strength and mindful movement — designed to build sustainable foundations.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.78),
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _macroTile(
      String label, String value, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _primaryContainer.withOpacity(0.22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _primary, size: 16),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _primary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: _onSurface),
          ),
          Text(
            sub,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10, color: _secondary),
          ),
        ],
      ),
    );
  }

  Widget _programChip(String text) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
