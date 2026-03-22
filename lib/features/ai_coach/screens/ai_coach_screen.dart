import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../analytics/screens/progress_analytics_screen.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
import '../../workout/screens/workout_library_screen.dart';

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _onSurface = Color(0xFF303333);
  static const _secondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);

  int _currentNavIndex = 4;
  int _selectedTab = 2; // Coach tab default

  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;
  bool _scheduleUpdated = false;

  final List<Map<String, String>> _messages = [
    {
      'sender': 'sage',
      'text':
          "I've noticed your evening screen time has crept up this week. Would you like a 5-minute guided decompression to help reset your melatonin levels before bed tonight?",
    },
    {
      'sender': 'user',
      'text':
          "That sounds exactly like what I need. Can you schedule it for 9:30 PM?",
    },
    {
      'sender': 'sage',
      'text':
          "Done. I've set a gentle reminder for 9:30 PM tonight. I'll guide you through a short breathing sequence to ease the transition to sleep. Rest well.",
    },
  ];

  static const _sageReplies = [
    "I hear you. Let me look at your recent patterns and suggest something that truly fits where you are right now.",
    "That's a thoughtful observation. Based on your recovery data, a gentler approach today will compound beautifully over time.",
    "Great. Small, consistent adjustments are where lasting change lives. You're already doing the right thing by tuning in.",
    "Noted. I'll factor that into tomorrow's plan. Your body's signals are always the most important data point.",
    "Beautiful. Rest is productive. Honoring your energy today is an investment in every session that follows.",
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _messageController.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    setState(() {
      _isTyping = false;
      _messages.add({
        'sender': 'sage',
        'text': _sageReplies[_messages.length % _sageReplies.length],
      });
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(context),
            _tabBar(),
            Expanded(
              child: _selectedTab == 2
                  ? _coachView()
                  : _placeholderTab(_selectedTab),
            ),
            if (_selectedTab == 2) _chatInput(),
            _bottomNav(bottomPadding),
          ],
        ),
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primaryContainer,
            ),
            child: const Icon(Icons.person, color: _primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning, Julianne',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Sage is ready for you',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12, color: _secondary),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Settings',
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _outline),
              ),
              child: const Icon(Icons.settings_outlined,
                  color: _secondary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Tab Bar ───────────────────────────────────────────────────────────────

  Widget _tabBar() {
    const tabs = ['Sanctuary', 'Progress', 'Coach', 'Journal'];

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: _outline, width: 1)),
        color: _cardBg,
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isActive = _selectedTab == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? _primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tabs[i],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? _primary : _secondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── Coach Tab ─────────────────────────────────────────────────────────────

  Widget _coachView() {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      children: [
        _dailyBriefingCard(),
        const SizedBox(height: 14),
        _strategicAdjustmentCard(),
        const SizedBox(height: 14),
        _weeklyHighlightCard(),
        const SizedBox(height: 14),
        _postFlowFuelCard(),
        const SizedBox(height: 22),
        _chatDivider(),
        const SizedBox(height: 14),
        ..._messages.map(_buildMessage),
        if (_isTyping) _typingBubble(),
        const SizedBox(height: 8),
      ],
    );
  }

  // ─── Daily Briefing ────────────────────────────────────────────────────────

  Widget _dailyBriefingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E6451), Color(0xFF3A4D3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.spa, color: Color(0xFFBFDAC1), size: 16),
              const SizedBox(width: 6),
              Text(
                'Daily Briefing from Sage',
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
            'Today is for steady grounding',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          // Stats row
          Row(
            children: [
              _briefingStat(
                Icons.bedtime_outlined,
                '8h 12m',
                'Sleep',
                'Excellent',
              ),
              const SizedBox(width: 10),
              _briefingStat(
                Icons.bolt,
                'Moderate',
                'Energy',
                null,
              ),
              const SizedBox(width: 10),
              _briefingStat(
                Icons.restaurant_outlined,
                'On Track',
                'Fuel',
                null,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Deep sleep was 15% lower than your average — yesterday\'s high-volume lower body session is still resonating. A gentler pace today will serve you well.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.88),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _briefingStat(
      IconData icon, String value, String label, String? badge) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFFBFDAC1), size: 16),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFBFDAC1).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      color: const Color(0xFFBFDAC1),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ─── Strategic Adjustment ──────────────────────────────────────────────────

  Widget _strategicAdjustmentCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAEFDE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.tune,
                    color: Color(0xFF655E51), size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Strategic Adjustment',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: _primaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              'Restorative Flow  >  HIIT',
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Your HRV is slightly suppressed this morning. Swapping your 30min HIIT for a 20min Restorative Flow will aid nervous system recovery.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: _secondary,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() => _scheduleUpdated = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Schedule updated — Restorative Flow added for today.',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    backgroundColor: _primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _scheduleUpdated
                    ? _primaryContainer
                    : _primary,
                foregroundColor:
                    _scheduleUpdated ? _primary : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                _scheduleUpdated ? 'Schedule Updated' : 'Update Schedule',
                style: GoogleFonts.manrope(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Weekly Highlight ──────────────────────────────────────────────────────

  Widget _weeklyHighlightCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_outline,
                        color: Color(0xFF655E51), size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Weekly Highlight',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'You\'ve been incredibly consistent with your morning mobility — your sleep quality has improved by 12%.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: _secondary,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.local_fire_department,
                    color: _primary, size: 22),
              ),
              const SizedBox(height: 6),
              Text(
                '14 Days',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              ),
              Text(
                'Grounded',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10, color: _secondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Post-Flow Fuel ────────────────────────────────────────────────────────

  Widget _postFlowFuelCard() {
    final foods = [
      {
        'name': 'Tempeh Power Bowl',
        'p': '32g P',
        'f': '12g F',
        'c': '48g C',
        'icon': Icons.rice_bowl_outlined,
      },
      {
        'name': 'Avocado & Egg Toast',
        'p': '18g P',
        'f': '24g F',
        'c': '30g C',
        'icon': Icons.breakfast_dining_outlined,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.restaurant_outlined,
                      color: _primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Post-Flow Fuel',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '840 kcal remaining',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: _primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...foods.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${f['name']} added to your meal plan.',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    backgroundColor: _primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    duration: const Duration(seconds: 2),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _outline),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _primaryContainer.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(f['icon'] as IconData,
                            color: _primary, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          f['name'] as String,
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _onSurface,
                          ),
                        ),
                      ),
                      Row(
                        children: [f['p'], f['f'], f['c']].map((label) {
                          return Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              label as String,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10, color: _secondary),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Chat ──────────────────────────────────────────────────────────────────

  Widget _chatDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: _outline, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.spa, color: _primary, size: 14),
              ),
              const SizedBox(width: 6),
              Text(
                'Sage',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Divider(color: _outline, height: 1)),
      ],
    );
  }

  Widget _buildMessage(Map<String, String> msg) {
    final isSage = msg['sender'] == 'sage';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isSage ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isSage) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.spa, color: _primary, size: 16),
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: isSage ? _cardBg : _primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isSage ? 4 : 16),
                  bottomRight: Radius.circular(isSage ? 16 : 4),
                ),
                border: isSage ? Border.all(color: _outline) : null,
              ),
              child: Text(
                msg['text']!,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: isSage ? _onSurface : Colors.white,
                  height: 1.55,
                ),
              ),
            ),
          ),
          if (!isSage) ...[
            const SizedBox(width: 10),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: _primary, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  Widget _typingBubble() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.spa, color: _primary, size: 16),
          ),
          const SizedBox(width: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: _outline),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 400 + i * 150),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Chat Input ────────────────────────────────────────────────────────────

  Widget _chatInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border(top: BorderSide(color: _outline, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14, color: _onSurface),
              decoration: InputDecoration(
                hintText: 'Ask Sage anything...',
                hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: const Color(0xFFB0B2B2)),
                filled: true,
                fillColor: _bg,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9999),
                  borderSide: const BorderSide(color: _outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9999),
                  borderSide: const BorderSide(color: _outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9999),
                  borderSide:
                      const BorderSide(color: _primary, width: 1.5),
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: _primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Other Tab Placeholders ────────────────────────────────────────────────

  Widget _placeholderTab(int tab) {
    final content = {
      0: ('spa', 'Sanctuary', 'Your mindful space for reflection and\ninner calm. Coming soon.'),
      1: ('insights', 'Progress', 'Your performance trends and insights\nare being prepared by Sage.'),
      3: ('book_outlined', 'Journal', 'Your daily reflections and\nmindful notes live here.'),
    };

    final item = content[tab]!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _primaryContainer.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                tab == 0
                    ? Icons.spa
                    : tab == 1
                        ? Icons.insights
                        : Icons.book_outlined,
                color: _primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.$2,
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.$3,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: _secondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bottom Nav ────────────────────────────────────────────────────────────

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
        border: Border(top: BorderSide(color: _outline, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              setState(() => _currentNavIndex = index);
              if (index == 0) {
                Navigator.popUntil(context, (r) => r.isFirst);
              } else if (index == 1) {
                Navigator.pushReplacement(
                    context,
                    AppRoute(page: const WorkoutLibraryScreen()));
              } else if (index == 2) {
                Navigator.pushReplacement(
                    context,
                    AppRoute(page: const NutritionHubScreen()));
              } else if (index == 3) {
                Navigator.pushReplacement(
                    context,
                    AppRoute(page: const ProgressAnalyticsScreen()));
              }
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
                color: isActive ? _primary : _secondary,
                size: 22,
              ),
            ),
          );
        }),
      ),
    );
  }
}
