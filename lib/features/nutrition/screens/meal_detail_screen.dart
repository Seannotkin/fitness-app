import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({super.key});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  int _selectedServing = 1; // 0=Small, 1=Standard, 2=Large
  double _servingCount = 1.5;
  bool _isFavourite = false;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topBar(context),
                    _heroArea(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _mealTitle(),
                          const SizedBox(height: 24),
                          _nutritionFacts(),
                          const SizedBox(height: 24),
                          _servingControl(),
                          const SizedBox(height: 24),
                          _chefNote(),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _actionButtons(bottomPadding),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _cardBg,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: _textPrimary, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Sage & Solace',
              style: GoogleFonts.manrope(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                letterSpacing: -0.34,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isFavourite = !_isFavourite),
            child: Icon(
              _isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: _isFavourite ? const Color(0xFFD75E5E) : _textSecondary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Icon(Icons.settings_outlined, color: _textSecondary, size: 22),
        ],
      ),
    );
  }

  Widget _heroArea() {
    return Container(
      height: 230,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3B5E42),
            const Color(0xFF5C8060),
            const Color(0xFF8FAD84),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -25,
            top: -25,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            left: -15,
            bottom: -30,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.set_meal_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Dinner Choice',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Roasted Salmon\n& Spring Greens',
          style: GoogleFonts.manrope(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _textPrimary,
            letterSpacing: -0.52,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: _primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Dinner',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.eco_outlined, color: _primary, size: 14),
            const SizedBox(width: 4),
            Text(
              'High Protein · Omega-3',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _nutritionFacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Facts',
          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Per serving · 420 kcal',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: _textSecondary,
          ),
        ),
        const SizedBox(height: 14),

        // Calories — full width prominent
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primary, _primary.withValues(alpha: 0.85)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Energy',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.75),
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    '420 kcal',
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.56,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.local_fire_department_rounded,
                  color: Colors.white54, size: 36),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // 2×2 macro grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.0,
          children: [
            _macroTile('Protein', '34g', const Color(0xFF4E6451), _primaryContainer),
            _macroTile('Carbs', '12g', const Color(0xFF7B6B3A), const Color(0xFFF2EAD3)),
            _macroTile('Fats', '28g', const Color(0xFF5B7EA6), const Color(0xFFDCEAF5)),
            _macroTile('Fiber', '6g', const Color(0xFF9B5E82), const Color(0xFFF2DFF0)),
          ],
        ),
      ],
    );
  }

  Widget _macroTile(
      String label, String value, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: textColor.withValues(alpha: 0.7),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -0.44,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _servingControl() {
    final sizes = ['Small', 'Standard', 'Large'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Serving Size',
          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 14),

        // +/- counter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _outline, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  if (_servingCount > 0.5) _servingCount -= 0.5;
                }),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove_rounded,
                      color: _primary, size: 18),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${_servingCount.toStringAsFixed(1)} Servings',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _textPrimary,
                      letterSpacing: -0.36,
                    ),
                  ),
                  Text(
                    '${(_servingCount * 420).round()} kcal total',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _servingCount += 0.5),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Size presets
        Row(
          children: List.generate(sizes.length, (i) {
            final isSelected = _selectedServing == i;
            return Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: i < sizes.length - 1 ? 8 : 0),
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedServing = i;
                    _servingCount = i == 0 ? 0.5 : i == 1 ? 1.0 : 2.0;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? _primary : _cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? _primary : _outline,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      sizes[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : _textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _chefNote() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color(0xFFE6A817).withValues(alpha: 0.25), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0C0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Color(0xFFE6A817), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chef's Wellness Tip",
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF7A5A00),
                    letterSpacing: -0.26,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'For maximum nutrient absorption, lightly zest a fresh lemon over the greens just before serving. Vitamin C enhances iron absorption from spring greens.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF7A5A00).withValues(alpha: 0.85),
                    height: 1.55,
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

  Widget _actionButtons(double bottomPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 14 + bottomPadding),
      decoration: BoxDecoration(
        color: _bg,
        border: const Border(top: BorderSide(color: _outline, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary: Log Meal & Finish
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: _primary,
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(
                    color: _primary.withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Log Meal & Finish',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Secondary: Add to Journal
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added to your wellness journal.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13),
                  ),
                  backgroundColor: const Color(0xFF4E6451),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: _primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.book_outlined,
                      color: _primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Add to Journal',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _primary,
                      letterSpacing: -0.3,
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
}
