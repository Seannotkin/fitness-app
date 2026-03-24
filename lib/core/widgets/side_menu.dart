import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/user_prefs.dart';
import '../routes/app_route.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/settings_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _textPrimary = Color(0xFF303333);
  static const _textSecondary = Color(0xFF5A605C);
  static const _outline = Color(0xFFE1E3E3);
  static const _surface = Color(0xFFFBFAF8);

  String _userName = 'Friend';
  String _userInitials = 'F';
  String _memberSince = '';
  int _streak = 1;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await UserPrefs.getName();
    final memberSince = await UserPrefs.getFirstLaunchDate();
    final streak = await UserPrefs.getStreak();
    if (mounted) {
      setState(() {
        _userName = name;
        _memberSince = memberSince;
        _streak = streak;
        final parts = name.trim().split(' ');
        _userInitials = parts.length >= 2
            ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
            : name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            decoration: BoxDecoration(
              color: _surface.withValues(alpha: 0.88),
              border: const Border(
                left: BorderSide(color: Colors.white30, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: _primary.withValues(alpha: 0.1),
                  blurRadius: 80,
                  offset: const Offset(-20, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: topPadding + 16),
                // Close button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: _outline),
                        ),
                        child: const Icon(Icons.close_rounded, color: _textSecondary, size: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // User profile
                _userProfile(),
                const SizedBox(height: 28),
                // Nav sections
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel('My Daily Flow'),
                        const SizedBox(height: 8),
                        _navItem(Icons.air_rounded, 'Daily Breath', () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Daily Breath coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        _navItem(Icons.fitness_center_rounded, 'Movement', () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Movement coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        const SizedBox(height: 20),
                        _sectionLabel('Explore Library'),
                        const SizedBox(height: 8),
                        _navItem(Icons.local_library_rounded, 'Wellness Library', () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Wellness Library coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        const SizedBox(height: 20),
                        _sectionLabel('Account'),
                        const SizedBox(height: 8),
                        _navItem(Icons.person_outline_rounded, 'Profile', () {
                          Navigator.pop(context);
                          Navigator.push(context, AppRoute(page: const ProfileScreen()));
                        }),
                        _navItem(Icons.settings_outlined, 'Settings', () {
                          Navigator.pop(context);
                          Navigator.push(context, AppRoute(page: const SettingsScreen()));
                        }),
                        const SizedBox(height: 20),
                        _sectionLabel('Support & Community'),
                        const SizedBox(height: 8),
                        _navItem(Icons.groups_rounded, 'Community', () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Community coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        _navItem(Icons.help_outline_rounded, 'Support', () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Support coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // Sign out
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _signOutButton(),
                ),
                const SizedBox(height: 12),
                // Version
                Text(
                  'v2.4.1',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: _textSecondary.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: bottomPadding + 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Member since $_memberSince',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: _textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Flowing: Day $_streak',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _primary,
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

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _textSecondary.withValues(alpha: 0.7),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: _primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _primary, size: 18),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signOutButton() {
    return GestureDetector(
      onTap: () {
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
                onPressed: () async {
                  Navigator.pop(ctx);
                  await UserPrefs.clearOnboarding();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      AppRoute(page: const SplashScreen()),
                      (route) => false,
                    );
                  }
                },
                child: Text('Sign Out', style: GoogleFonts.plusJakartaSans(color: Colors.red, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Colors.red.withValues(alpha: 0.7), size: 18),
            const SizedBox(width: 8),
            Text(
              'Sign Out',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
