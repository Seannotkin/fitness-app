import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/user_prefs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _bg = Color(0xFFFBFAF8);
  static const _primary = Color(0xFF4E6451);
  static const _primaryContainer = Color(0xFFD0E9D1);
  static const _textPrimary = Color(0xFF303333);
  static const _textSecondary = Color(0xFF5A605C);
  static const _cardBg = Color(0xFFFFFFFF);
  static const _outline = Color(0xFFE1E3E3);
  static const _surfaceVariant = Color(0xFFE8F0EA);

  bool _dataSharing = false;
  bool _biometrics = true;
  bool _lightMode = true;
  String _userName = 'Friend';

  @override
  void initState() {
    super.initState();
    UserPrefs.getName().then((name) {
      if (mounted) setState(() => _userName = name);
    });
  }
  bool _darkMode = false;
  String _typography = 'Standard';

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: bottomPadding + 20,
                  top: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionCard(
                      'Account Settings',
                      [
                        _navRow(Icons.email_outlined, 'Email Address', 'avery.solace@email.com', () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Edit email coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        _divider(),
                        _navRow(Icons.lock_outline_rounded, 'Password', 'Last changed 3 months ago', () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Change password coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        _divider(),
                        _navRow(Icons.card_membership_rounded, 'Subscription', 'Premium • Active until Dec 2024', () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Subscription details coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _sectionCard(
                      'Privacy & Security',
                      [
                        _toggleRow(Icons.share_outlined, 'Data Sharing', _dataSharing, (v) => setState(() => _dataSharing = v)),
                        _divider(),
                        _toggleRow(Icons.fingerprint_rounded, 'Biometrics', _biometrics, (v) => setState(() => _biometrics = v)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _sectionCard(
                      'Notifications',
                      [
                        _notificationNavRow(
                          Icons.alarm_rounded,
                          'Daily Reminders',
                          '8:00 AM Morning Breath',
                          recommended: true,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Reminder settings coming soon'), duration: Duration(seconds: 2)),
                            );
                          },
                        ),
                        _divider(),
                        _navRow(Icons.vibration_rounded, 'Sound & Haptics', null, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sound & haptics coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _sectionCard(
                      'Display & Appearance',
                      [
                        _toggleRow(Icons.light_mode_outlined, 'Light Mode', _lightMode, (v) => setState(() {
                          _lightMode = v;
                          if (v) _darkMode = false;
                        })),
                        _divider(),
                        _toggleRow(Icons.dark_mode_outlined, 'Dark Mode', _darkMode, (v) => setState(() {
                          _darkMode = v;
                          if (v) _lightMode = false;
                        })),
                        _divider(),
                        _typographyRow(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _sectionCard(
                      'App Info',
                      [
                        _navRow(Icons.info_outline_rounded, 'Version', '2.4.1 (Stable)', null),
                        _divider(),
                        _navRow(Icons.help_outline_rounded, 'Support & Help Center', null, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Support center coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                        _divider(),
                        _navRow(Icons.policy_outlined, 'Privacy Policy', null, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Privacy policy coming soon'), duration: Duration(seconds: 2)),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _signOutButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _cardBg,
                shape: BoxShape.circle,
                border: Border.all(color: _outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_rounded, color: _textPrimary, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            'Settings',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _textSecondary,
                letterSpacing: 0.4,
              ),
            ),
          ),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _toggleRow(IconData icon, String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _textSecondary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: _primary,
            activeTrackColor: _primaryContainer,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: _outline,
          ),
        ],
      ),
    );
  }

  Widget _notificationNavRow(
    IconData icon,
    String label,
    String subtitle, {
    bool recommended = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _textSecondary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _textPrimary,
                        ),
                      ),
                      if (recommended) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'RECOMMENDED',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: _primary,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFBBBEBE), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _typographyRow() {
    const options = ['Small', 'Standard', 'Large'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.text_fields_rounded, color: _textSecondary, size: 18),
              ),
              const SizedBox(width: 14),
              Text(
                'Typography Scaling',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: options.map((opt) {
              final selected = opt == _typography;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _typography = opt),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? _primary : _surfaceVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        opt,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : _textSecondary,
                        ),
                      ),
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

  Widget _navRow(IconData icon, String label, String? subtitle, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _textSecondary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (onTap != null)
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

  Widget _signOutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Sign Out',
                style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: _textPrimary),
              ),
              content: Text(
                'Are you sure you want to sign out of Solace?',
                style: GoogleFonts.plusJakartaSans(color: _textSecondary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Cancel', style: GoogleFonts.plusJakartaSans(color: _textSecondary)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Sign Out', style: GoogleFonts.plusJakartaSans(color: Colors.red, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.logout_rounded, size: 18),
        label: Text(
          'Sign Out of $_userName',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
