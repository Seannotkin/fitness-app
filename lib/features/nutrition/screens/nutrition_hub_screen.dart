import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../analytics/screens/progress_analytics_screen.dart';
import '../../workout/screens/workout_library_screen.dart';

class NutritionHubScreen extends StatefulWidget {
  const NutritionHubScreen({super.key});

  @override
  State<NutritionHubScreen> createState() => _NutritionHubScreenState();
}

class _NutritionHubScreenState extends State<NutritionHubScreen> {
  int _currentNavIndex = 2;

  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFCFE3D4);
  static const _textPrimary = Color(0xFF303333);
  static const _textSecondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);
  static const _surfaceVariant = Color(0xFFE8F0EA);

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _calorieCard(),
                    const SizedBox(height: 16),
                    _nourishmentCard(),
                    const SizedBox(height: 20),
                    _mealsSection(),
                    const SizedBox(height: 16),
                    _nutrientInsight(),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryContainer,
            border: Border.all(color: _primary.withOpacity(0.3), width: 1.5),
          ),
          child: const Icon(Icons.person, color: _primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sage & Solace',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  letterSpacing: -0.36,
                ),
              ),
              Text(
                'Nutrition Hub',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: _textSecondary,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.settings_outlined, color: _textSecondary, size: 22),
      ],
    );
  }

  Widget _calorieCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primary,
            _primary.withOpacity(0.80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.28),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Calories',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.75),
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '1,420',
                      style: GoogleFonts.manrope(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.8,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'kcal left',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: 0.42,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '980 kcal consumed of 2,400 goal',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.restaurant_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nourishmentCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primary.withOpacity(0.12), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.eco_outlined, color: _primary, size: 18),
              const SizedBox(width: 8),
              Text(
                'Daily Nourishment',
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
            'Your body is feeling balanced today. Focus on hydrating during your next meal.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: _textSecondary,
              height: 1.5,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _macroChip(
                  'Protein',
                  '62g',
                  const Color(0xFF4E6451),
                  const Color(0xFFCFE3D4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _macroChip(
                  'Carbs',
                  '145g',
                  const Color(0xFF7B6B3A),
                  const Color(0xFFF2EAD3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _macroChip(
                  'Fats',
                  '38g',
                  const Color(0xFF5B7EA6),
                  const Color(0xFFDCEAF5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macroChip(
      String label, String value, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: textColor.withOpacity(0.75),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -0.36,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Meals",
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                    letterSpacing: -0.36,
                  ),
                ),
                Text(
                  'Oct 24, 2023',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: _textSecondary,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: _primaryContainer,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add, color: _primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Add Meal',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Breakfast
        _mealCard(
          mealType: 'Breakfast',
          name: 'Morning Berry Oats',
          calories: '340 kcal',
          detail: 'Steel cut oats, fresh blueberries, walnuts.',
          icon: Icons.breakfast_dining,
          iconColor: const Color(0xFFBF6A3A),
          iconBg: const Color(0xFFFDE8D8),
          logged: true,
        ),
        const SizedBox(height: 10),

        // Lunch
        _mealCard(
          mealType: 'Lunch',
          name: 'Garden Green Salad',
          calories: '410 kcal',
          detail: 'Kale, roasted chickpeas, lemon-tahini dressing.',
          icon: Icons.eco,
          iconColor: const Color(0xFF4E6451),
          iconBg: _primaryContainer,
          logged: true,
        ),
        const SizedBox(height: 10),

        // Dinner — not logged
        _dinnerPending(),
        const SizedBox(height: 10),

        // Snacks
        _mealCard(
          mealType: 'Snack',
          name: 'Handful of Almonds',
          calories: '160 kcal',
          detail: 'Raw, unsalted almonds (approx. 20 pieces).',
          icon: Icons.spa_outlined,
          iconColor: const Color(0xFF7B6B3A),
          iconBg: const Color(0xFFF2EAD3),
          logged: true,
        ),
      ],
    );
  }

  Widget _mealCard({
    required String mealType,
    required String name,
    required String calories,
    required String detail,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required bool logged,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        mealType,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: iconColor,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Text(
                      calories,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _textPrimary,
                        letterSpacing: -0.26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  name,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: _textSecondary,
                    height: 1.4,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dinnerPending() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outline, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EFED),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.dinner_dining,
                color: Color(0xFFADB5BD), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EFED),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    'Dinner',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFADB5BD),
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Not logged yet',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFADB5BD),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Prepare something warm and grounding.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: const Color(0xFFBCC2C8),
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                    letterSpacing: 0.1,
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
              decoration: BoxDecoration(
                color: _primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: _primary, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutrientInsight() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outline, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.lightbulb_outline,
                color: Color(0xFFE6A817), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nutrient Insight',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                    letterSpacing: -0.28,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "You've hit 80% of your daily protein goal. Excellent for muscle recovery after yesterday's yoga session.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: _textSecondary,
                    height: 1.5,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottomPadding),
      decoration: BoxDecoration(
        color: _cardBg,
        border: const Border(top: BorderSide(color: _outline, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              if (index == 3) {
                Navigator.pushReplacement(
                  context,
                  AppRoute(page: const ProgressAnalyticsScreen()),
                );
                return;
              }
              setState(() => _currentNavIndex = index);
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
