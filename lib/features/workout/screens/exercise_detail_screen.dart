import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Map<String, dynamic> exercise;
  const ExerciseDetailScreen({super.key, required this.exercise});

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

  // ── Timer state ──
  Duration _elapsed = Duration.zero;
  bool _timerRunning = true;
  Timer? _timer;

  // ── Session state ──
  late int _currentSet;
  late int _totalSets;
  late int _repsLogged;
  late int _targetReps;
  late int _weight;
  late int _restSeconds;

  @override
  void initState() {
    super.initState();
    final e = widget.exercise;
    _currentSet = 1;
    _totalSets = (e['sets'] as int?) ?? 3;
    _repsLogged = 0;
    _targetReps = (e['reps'] as int?) ?? 10;
    _weight = (e['weight'] as int?) ?? 0;
    _restSeconds = (e['restSeconds'] as int?) ?? 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timerRunning && mounted) {
        setState(() => _elapsed += const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _elapsedDisplay {
    final m = _elapsed.inMinutes.toString().padLeft(2, '0');
    final s = (_elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get _setProgress => _totalSets == 0 ? 0 : (_currentSet - 1) / _totalSets;

  void _toggleTimer() => setState(() => _timerRunning = !_timerRunning);

  void _logSet() {
    if (_currentSet < _totalSets) {
      setState(() {
        _currentSet++;
        _repsLogged = 0;
      });
    } else {
      _showCompleteDialog();
    }
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: _cardBg,
        title: Text(
          'Workout Complete!',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: _onSurface),
        ),
        content: Text(
          'You finished all $_totalSets sets of ${widget.exercise['title']}. Great work!',
          style: GoogleFonts.plusJakartaSans(color: _secondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text('Done', style: GoogleFonts.plusJakartaSans(color: _primary, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: _cardBg,
        title: Text(
          'End Session?',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: _onSurface),
        ),
        content: Text(
          'Are you sure you want to end this session early?',
          style: GoogleFonts.plusJakartaSans(color: _secondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Keep Going', style: GoogleFonts.plusJakartaSans(color: _secondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text('End Session', style: GoogleFonts.plusJakartaSans(color: Colors.red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog() {
    int tmpSets = _totalSets;
    int tmpReps = _targetReps;
    int tmpWeight = _weight;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setDlg) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: _cardBg,
          title: Text('Edit Session', style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: _onSurface)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _editRow('Sets', tmpSets, (v) => setDlg(() => tmpSets = v), min: 1, max: 10),
              const SizedBox(height: 14),
              _editRow('Reps', tmpReps, (v) => setDlg(() => tmpReps = v), min: 1, max: 50),
              const SizedBox(height: 14),
              _editRow('Weight (kg)', tmpWeight, (v) => setDlg(() => tmpWeight = v), min: 0, max: 300, step: 5),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: GoogleFonts.plusJakartaSans(color: _secondary)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _totalSets = tmpSets;
                  _targetReps = tmpReps;
                  _weight = tmpWeight;
                  if (_currentSet > _totalSets) _currentSet = _totalSets;
                });
                Navigator.pop(ctx);
              },
              child: Text('Save', style: GoogleFonts.plusJakartaSans(color: _primary, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editRow(String label, int value, ValueChanged<int> onChange,
      {int min = 0, int max = 100, int step = 1}) {
    return Row(
      children: [
        Expanded(
          child: Text(label,
              style: GoogleFonts.plusJakartaSans(
                  color: _onSurface, fontWeight: FontWeight.w600)),
        ),
        GestureDetector(
          onTap: () {
            if (value - step >= min) onChange(value - step);
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.remove, size: 16, color: _onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text('$value',
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: _onSurface)),
        ),
        GestureDetector(
          onTap: () {
            if (value + step <= max) onChange(value + step);
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: _primaryContainer,
                borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add, size: 16, color: _primary),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.exercise;
    final muscles = (e['muscles'] as List?)?.cast<String>() ?? [];
    final tips = (e['tips'] as List?)?.cast<String>() ?? [];
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          _header(e['title'] as String? ?? 'Exercise'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _timerCard(),
                  const SizedBox(height: 16),
                  _setProgressCard(),
                  const SizedBox(height: 16),
                  _currentSetCard(),
                  const SizedBox(height: 16),
                  _restCard(),
                  const SizedBox(height: 16),
                  if (muscles.isNotEmpty) ...[
                    _musclesCard(muscles),
                    const SizedBox(height: 16),
                  ],
                  if (tips.isNotEmpty) _tipsSection(tips),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _actionBar(bottomPadding),
        ],
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _header(String title) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: _showEndDialog,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _outline),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    size: 18, color: _onSurface),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _onSurface),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                        color: _primary, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 5),
                  Text('Session Active',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: _primary,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            GestureDetector(
              onTap: _showEditDialog,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.edit_note, color: _secondary, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Timer Card ────────────────────────────────────────────────────────────

  Widget _timerCard() {
    return GestureDetector(
      onTap: _toggleTimer,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4E6451), Color(0xFF3A4D3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Icon(
              _timerRunning
                  ? Icons.timer_outlined
                  : Icons.timer_off_outlined,
              color: const Color(0xFFBFDAC1),
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _timerRunning ? 'Session Running' : 'Session Paused',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFFBFDAC1)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _elapsedDisplay,
                    style: GoogleFonts.manrope(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _timerRunning
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Set Progress ──────────────────────────────────────────────────────────

  Widget _setProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _outline)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Session Progress',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: _secondary,
                      fontWeight: FontWeight.w500)),
              Text(
                'Set $_currentSet of $_totalSets',
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _onSurface),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: _setProgress,
              backgroundColor: const Color(0xFFE8EDEA),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(_primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(_setProgress * 100).round()}% Complete',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11, color: _secondary),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Current Set Card ──────────────────────────────────────────────────────

  Widget _currentSetCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Current Set',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: _secondary,
                      fontWeight: FontWeight.w500)),
              const Spacer(),
              Text(
                _weight > 0
                    ? 'Target: $_targetReps reps @ ${_weight}kg'
                    : 'Target: $_targetReps reps',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: _primary,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (_repsLogged > 0) {
                    setState(() => _repsLogged--);
                  }
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12)),
                  child:
                      const Icon(Icons.remove, size: 20, color: _onSurface),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    Text(
                      '$_repsLogged',
                      style: GoogleFonts.manrope(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: _onSurface),
                    ),
                    Text('Reps Logged',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12, color: _secondary)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _repsLogged++),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: _primaryContainer,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.add, size: 20, color: _primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Rest Card ─────────────────────────────────────────────────────────────

  Widget _restCard() {
    if (_restSeconds == 0) return const SizedBox.shrink();
    final m = _restSeconds ~/ 60;
    final s = _restSeconds % 60;
    final display =
        m > 0 ? '${m}m${s > 0 ? ' ${s}s' : ''}' : '${s}s';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primaryContainer),
      ),
      child: Row(
        children: [
          const Icon(Icons.bedtime_outlined, color: _primary, size: 18),
          const SizedBox(width: 10),
          Text('Suggested Rest:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, color: _secondary)),
          const SizedBox(width: 6),
          Text(display,
              style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _primary)),
        ],
      ),
    );
  }

  // ─── Muscles Card ──────────────────────────────────────────────────────────

  Widget _musclesCard(List<String> muscles) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.accessibility_new,
                  color: _primary, size: 18),
              const SizedBox(width: 8),
              Text('Target Muscles',
                  style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _onSurface)),
            ],
          ),
          const SizedBox(height: 12),
          ...muscles.map((m) {
            final isPrimary = m.contains('(Primary)');
            final label = m.replaceAll(' (Primary)', '');
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isPrimary
                          ? _primary
                          : _secondary.withValues(alpha: 0.35),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(label,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: _onSurface,
                          fontWeight: FontWeight.w500)),
                  if (isPrimary) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                          color: _primaryContainer,
                          borderRadius: BorderRadius.circular(9999)),
                      child: Text('Primary',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: _primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Tips Section ──────────────────────────────────────────────────────────

  Widget _tipsSection(List<String> tips) {
    final tipIcons = [
      Icons.straighten,
      Icons.visibility_outlined,
      Icons.compress,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mindful Reminders',
            style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _onSurface)),
        const SizedBox(height: 10),
        ...List.generate(tips.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _outline)),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: _primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(tipIcons[i % tipIcons.length],
                        color: _primary, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(tips[i],
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: _onSurface,
                            height: 1.4)),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // ─── Action Bar ────────────────────────────────────────────────────────────

  Widget _actionBar(double bottomPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 14 + bottomPadding),
      decoration: BoxDecoration(
        color: _cardBg,
        border: const Border(top: BorderSide(color: _outline)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, -4))
        ],
      ),
      child: Row(
        children: [
          _actionBtn(
            icon: _timerRunning
                ? Icons.pause_circle_outline
                : Icons.play_circle_outline,
            label: _timerRunning ? 'Pause' : 'Resume',
            color: _secondary,
            onTap: _toggleTimer,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: _logSet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _currentSet < _totalSets
                          ? 'Log Set $_currentSet'
                          : 'Finish',
                      style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _actionBtn(
            icon: Icons.stop_circle_outlined,
            label: 'End',
            color: Colors.red.shade400,
            onTap: _showEndDialog,
          ),
        ],
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(label,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
