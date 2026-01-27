import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../common/primary_button.dart';

/// Mobile hamburger menu overlay that slides down from nav bar
class HamburgerMenuOverlay extends StatelessWidget {
  final List<Map<String, String>> navLinks;
  final String activeSection;
  final Function(String) onNavLinkTap;
  final VoidCallback onDownloadTap;
  final VoidCallback onClose;

  const HamburgerMenuOverlay({
    super.key,
    required this.navLinks,
    required this.activeSection,
    required this.onNavLinkTap,
    required this.onDownloadTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose, // Close when tapping outside
      child: Container(
        color: Colors.transparent,
        child: Positioned(
          top: 64, // Below the nav bar
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {}, // Prevent close when tapping menu itself
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundPrimary.withValues(alpha: 0.98),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.cyanAccent.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Navigation links
                  ...navLinks.map((link) {
                    final isActive = activeSection == link['section'];

                    return _buildMenuLink(
                      label: link['label']!,
                      isActive: isActive,
                      onTap: () => onNavLinkTap(link['section']!),
                    );
                  }),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      height: 1,
                      color: AppTheme.cyanAccent.withValues(alpha: 0.2),
                    ),
                  ),

                  // CTA button
                  PrimaryButton(
                    text: 'Join Beta',
                    onPressed: onDownloadTap,
                    width: double.infinity,
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuLink({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 48, // Minimum touch target
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.cyanAccent.withValues(alpha: 0.1)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isActive ? AppTheme.cyanAccent : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.tiny5(
              fontSize: 17,
              color: isActive ? AppTheme.cyanAccent : Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
