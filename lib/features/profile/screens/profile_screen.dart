import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes/app_route.dart';
import '../../ai_coach/screens/ai_coach_screen.dart';
import '../../analytics/screens/progress_analytics_screen.dart';
import '../../nutrition/screens/nutrition_hub_screen.dart';
import '../../workout/screens/workout_library_screen.dart';
import '../../../core/services/user_prefs.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _textPrimary = Color(0xFF303333);
  static const _textSecondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);
  static const _surfaceVariant = Color(0xFFE8F0EA);

  final TextEditingController _reflectionCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();
  int _currentNavIndex = -1;
  String _userName = 'Friend';
  String _userInitials = 'F';
  String _memberSince = '';
  int _streak = 1;
  bool _editingBio = false;
  bool _bioIsCustom = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await UserPrefs.getName();
    final memberSince = await UserPrefs.getFirstLaunchDate();
    final streak = await UserPrefs.getStreak();
    final bio = await UserPrefs.getBio();
    final bioIsCustom = await UserPrefs.isBioCustom();
    if (mounted) {
      setState(() {
        _userName = name;
        _memberSince = memberSince;
        _streak = streak;
        _bioCtrl.text = bio;
        _bioIsCustom = bioIsCustom;
        final parts = name.trim().split(' ');
        _userInitials = parts.length >= 2
            ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
            : name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
      });
    }
  }

  @override
  void dispose() {
    _reflectionCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 24),
                    _userCard(),
                    const SizedBox(height: 20),
                    _metricsGrid(),
                    const SizedBox(height: 20),
                    _achievementsSection(),
                    const SizedBox(height: 20),
                    _activityChart(),
                    const SizedBox(height: 20),
                    _dailyReflection(),
                    const SizedBox(height: 20),
                    _accountSection(),
                    const SizedBox(height: 8),
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
      children: [
        Expanded(
          child: Text(
            'Solace',
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
              letterSpacing: -0.5,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Menu coming soon'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: _outline),
            ),
            child: const Icon(Icons.menu_rounded, color: _textSecondary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _userCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4E6451), Color(0xFF6B8F6E)],
                  ),
                  border: Border.all(color: _primary.withValues(alpha: 0.2), width: 2),
                ),
                child: Center(
                  child: Text(
                    _userInitials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName,
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Member since $_memberSince',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Edit profile coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: _primary),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Edit',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _editingBio
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _bioCtrl,
                      maxLines: 3,
                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: _textPrimary, height: 1.6),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _bg,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _outline)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _outline)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _primary, width: 1.5)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await UserPrefs.saveBio(_bioCtrl.text, isCustom: true);
                            setState(() { _editingBio = false; _bioIsCustom = true; });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(color: _primary, borderRadius: BorderRadius.circular(20)),
                            child: Text('Save', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (_bioIsCustom)
                          GestureDetector(
                            onTap: () async {
                              await UserPrefs.resetBioToGenerated();
                              final bio = await UserPrefs.getBio();
                              setState(() { _bioCtrl.text = bio; _bioIsCustom = false; _editingBio = false; });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(border: Border.all(color: _outline), borderRadius: BorderRadius.circular(20)),
                              child: Text('Reset to auto', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: _textSecondary)),
                            ),
                          ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => _editingBio = false),
                          child: Text('Cancel', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: _textSecondary)),
                        ),
                      ],
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () => setState(() => _editingBio = true),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _bioCtrl.text.isEmpty ? 'Tap to add your bio...' : _bioCtrl.text,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13, color: _bioCtrl.text.isEmpty ? _textSecondary.withValues(alpha: 0.5) : _textSecondary, height: 1.6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.edit_outlined, size: 14, color: _textSecondary.withValues(alpha: 0.5)),
                    ],
                  ),
                ),
          const SizedBox(height: 16),
          Row(
            children: [
              _statChip(Icons.local_fire_department_outlined, '$_streak', 'Day Streak'),
              const SizedBox(width: 8),
              _statChip(Icons.directions_walk_rounded, '—', 'Steps Today'),
              const SizedBox(width: 8),
              _statChip(Icons.monitor_heart_outlined, '—', 'HRV'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: _surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: _primary, size: 18),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.manrope(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Journey',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.7,
          children: [
            _metricCard(Icons.local_fire_department_outlined, 'Current Streak', '$_streak Days', null),
            _metricCard(Icons.directions_walk_rounded, 'Steps', 'Not synced', null),
            _metricCard(Icons.monitor_heart_outlined, 'HRV', 'Not synced', null),
            _metricCard(Icons.bedtime_outlined, 'Sleep', 'Not synced', null),
          ],
        ),
        const SizedBox(height: 12),
        _metricCardWide(Icons.timer_outlined, 'Active Time', 'Not synced', 'Connect device'),
      ],
    );
  }

  Widget _metricCard(IconData icon, String label, String value, String? subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _primary, size: 16),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: _textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: _primary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _metricCardWide(IconData icon, String label, String value, String badge) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _primary, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: _textSecondary,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _achievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Achievements',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All achievements coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'See all',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _achievementCard(Icons.workspace_premium_rounded, 'Consistency Master', '10-day streak achieved')),
            const SizedBox(width: 12),
            Expanded(child: _achievementCard(Icons.psychology_rounded, 'Mindful Explorer', '50 diverse sessions')),
          ],
        ),
      ],
    );
  }

  Widget _achievementCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primaryContainer, _primaryContainer.withValues(alpha: 0.5)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: _textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityChart() {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const heights = [0.5, 0.8, 0.6, 0.9, 0.4, 0.7, 0.3];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Activity Volume',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Last 7 Days',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isToday = i == 5;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400 + i * 60),
                          curve: Curves.easeOutCubic,
                          height: 60 * heights[i],
                          decoration: BoxDecoration(
                            color: isToday ? _primary : _primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          days[i],
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                            color: isToday ? _primary : _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dailyReflection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_awesome, color: Color(0xFFB8860B), size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'Daily Reflection',
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _reflectionCtrl,
            maxLines: 4,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: _textPrimary,
              height: 1.6,
            ),
            decoration: InputDecoration(
              hintText: 'How are you feeling today? What are you grateful for...',
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: _textSecondary.withValues(alpha: 0.6),
              ),
              filled: true,
              fillColor: _bg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: _outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: _outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: _primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reflection saved to your journal'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Save Note',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountSection() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              'Account & Experience',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _textSecondary,
                letterSpacing: 0.3,
              ),
            ),
          ),
          _accountRow(Icons.person_outline_rounded, 'Personal Information', null, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Personal information coming soon'), duration: Duration(seconds: 2)),
            );
          }),
          _divider(),
          _accountRow(Icons.lock_outline_rounded, 'Privacy & Data', null, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Privacy & data coming soon'), duration: Duration(seconds: 2)),
            );
          }),
          _divider(),
          _accountRow(Icons.notifications_none_rounded, 'Notifications', null, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications coming soon'), duration: Duration(seconds: 2)),
            );
          }),
          _divider(),
          _accountRow(Icons.light_mode_outlined, 'App Theme', 'Light', () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Theme settings coming soon'), duration: Duration(seconds: 2)),
            );
          }),
          _divider(),
          _accountRow(Icons.settings_outlined, 'Settings', null, () {
            Navigator.of(context).push(AppRoute(page: const SettingsScreen()));
          }),
          _divider(),
          _accountRow(Icons.logout_rounded, 'Sign Out', null, () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Text(
                  'Sign Out',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: _textPrimary),
                ),
                content: Text(
                  'Are you sure you want to sign out?',
                  style: GoogleFonts.plusJakartaSans(color: _textSecondary),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text('Cancel', style: GoogleFonts.plusJakartaSans(color: _textSecondary)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text('Sign Out', style: GoogleFonts.plusJakartaSans(color: Colors.red)),
                  ),
                ],
              ),
            );
          }, isDestructive: true),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _accountRow(IconData icon, String label, String? trailing, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDestructive ? Colors.red.withValues(alpha: 0.08) : _surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: isDestructive ? Colors.red : _textSecondary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : _textPrimary,
                ),
              ),
            ),
            if (trailing != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trailing,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: _textSecondary,
                  ),
                ),
              ),
            if (!isDestructive)
              const Icon(Icons.chevron_right_rounded, color: Color(0xFFBBBEBE), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: _outline,
      indent: 20,
      endIndent: 20,
    );
  }

  Widget _bottomNav(double bottomPadding) {
    const items = [
      (Icons.home_rounded, Icons.home_outlined, 'Home'),
      (Icons.restaurant_rounded, Icons.restaurant_outlined, 'Nutrition'),
      (Icons.fitness_center_rounded, Icons.fitness_center_outlined, 'Workout'),
      (Icons.bar_chart_rounded, Icons.bar_chart_outlined, 'Progress'),
      (Icons.smart_toy_rounded, Icons.smart_toy_outlined, 'Sage'),
    ];

    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _outline, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = i == _currentNavIndex;
          final item = items[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => _onNavTap(i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selected ? item.$1 : item.$2,
                      color: selected ? _primary : _textSecondary,
                      size: 22,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.$3,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected ? _primary : _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _onNavTap(int index) {
    if (index == _currentNavIndex) return;
    setState(() => _currentNavIndex = index);

    Widget screen;
    switch (index) {
      case 0:
        Navigator.of(context).popUntil((r) => r.isFirst);
        return;
      case 1:
        screen = const NutritionHubScreen();
        break;
      case 2:
        screen = const WorkoutLibraryScreen();
        break;
      case 3:
        screen = const ProgressAnalyticsScreen();
        break;
      case 4:
        screen = const AiCoachScreen();
        break;
      default:
        return;
    }
    Navigator.of(context).pushReplacement(AppRoute(page: screen));
  }
}
