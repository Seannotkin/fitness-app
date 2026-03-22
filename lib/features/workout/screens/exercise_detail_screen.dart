import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({super.key});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _onSurface = Color(0xFF303333);
  static const _secondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);

  int _currentSet = 2;
  int _totalSets = 3;
  int _repCount = 12;
  int _load = 0;

  int _restSeconds = 45;
  bool _timerRunning = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_restSeconds > 0) {
        setState(() => _restSeconds--);
      } else {
        _timer?.cancel();
        setState(() => _timerRunning = false);
      }
    });
  }

  void _skipRest() {
    _timer?.cancel();
    setState(() {
      _restSeconds = 0;
      _timerRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _restSeconds = 45;
      _timerRunning = true;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerDisplay {
    final mins = _restSeconds ~/ 60;
    final secs = _restSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _exerciseHero(),
                    const SizedBox(height: 18),
                    _setTracker(),
                    const SizedBox(height: 12),
                    _controlsRow(),
                    const SizedBox(height: 12),
                    _restTimerCard(),
                    const SizedBox(height: 18),
                    _mindfulTip(),
                    const SizedBox(height: 24),
                    _actionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _outline),
              ),
              child: const Icon(Icons.arrow_back, color: _onSurface, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Sage & Solace',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Exercise settings',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                backgroundColor: _primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                duration: const Duration(seconds: 1),
              ),
            ),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _outline),
              ),
              child: const Icon(Icons.settings_outlined,
                  color: _onSurface, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Hero ──────────────────────────────────────────────────────────────────

  Widget _exerciseHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E6451), Color(0xFF3A4D3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Mobility & Rest',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.timer_outlined,
                  color: Color(0xFFBFDAC1), size: 14),
              const SizedBox(width: 4),
              Text(
                '10 min',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, color: const Color(0xFFBFDAC1)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Supported Heart Opener',
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gentle spinal extension focusing on chest expansion and breath awareness into upper ribs.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.82),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Set Tracker ───────────────────────────────────────────────────────────

  Widget _setTracker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outline),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Set',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: _secondary)),
                const SizedBox(height: 4),
                Text(
                  'Set $_currentSet of $_totalSets',
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_totalSets > 1) {
                    setState(() {
                      _totalSets--;
                      if (_currentSet > _totalSets) {
                        _currentSet = _totalSets;
                      }
                    });
                  }
                },
                child: _ctrlBtn(Icons.remove),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _totalSets++;
                    if (_currentSet < _totalSets) _currentSet++;
                  });
                },
                child: _ctrlBtn(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Reps + Load ───────────────────────────────────────────────────────────

  Widget _controlsRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mindful Reps',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: _secondary)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_repCount > 1) setState(() => _repCount--);
                      },
                      child: _ctrlBtn(Icons.remove),
                    ),
                    Text(
                      '$_repCount',
                      style: GoogleFonts.manrope(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _repCount++),
                      child: _ctrlBtn(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Load',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: _secondary)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_load >= 5) setState(() => _load -= 5);
                      },
                      child: _ctrlBtn(Icons.remove),
                    ),
                    Column(
                      children: [
                        Text(
                          '$_load',
                          style: GoogleFonts.manrope(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: _primary,
                          ),
                        ),
                        Text(
                          'lbs',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 11, color: _secondary),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _load += 5),
                      child: _ctrlBtn(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Rest Timer ────────────────────────────────────────────────────────────

  Widget _restTimerCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _primaryContainer.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primaryContainer),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        color: _primary, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Rest Timer',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: _secondary,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _timerDisplay,
                  style: GoogleFonts.manrope(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                    letterSpacing: 3,
                  ),
                ),
                if (!_timerRunning && _restSeconds == 0)
                  Text(
                    'Rest complete — ready to go!',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: _primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _timerRunning ? _skipRest : _resetTimer,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: _timerRunning ? _primary : _cardBg,
                borderRadius: BorderRadius.circular(9999),
                border: _timerRunning
                    ? null
                    : Border.all(color: _primary),
              ),
              child: Text(
                _timerRunning ? 'Skip' : 'Reset',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _timerRunning ? Colors.white : _primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Mindful Tip ───────────────────────────────────────────────────────────

  Widget _mindfulTip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAEFDE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline,
              color: Color(0xFF655E51), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mindful Tip',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF655E51),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '"Imagine your chest is a blooming flower. Each inhale expands the petals, each exhale lets the shoulders melt deeper into the mat."',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF655E51),
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

  // ─── Action Buttons ────────────────────────────────────────────────────────

  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Loading movement video...',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                backgroundColor: _primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                duration: const Duration(seconds: 2),
              ),
            ),
            icon: const Icon(Icons.play_circle_outline, size: 20),
            label: Text('Watch Movement',
                style: GoogleFonts.manrope(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            style: OutlinedButton.styleFrom(
              foregroundColor: _primary,
              side: const BorderSide(color: _primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_circle_outline, size: 20),
            label: Text('Finish Exercise',
                style: GoogleFonts.manrope(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  // ─── Helper ────────────────────────────────────────────────────────────────

  Widget _ctrlBtn(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: _primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(icon, color: _primary, size: 18),
    );
  }
}
