import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';

/// Footer with legal links and copyright
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
        vertical: 40,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.cyanAccent, width: 2)),
        color: AppTheme.backgroundPrimary,
      ),
      child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildLegalLinks(context),
        const SizedBox(height: 24),
        _buildCopyright(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLegalLinks(context),
        _buildCopyright(context),
      ],
    );
  }

  Widget _buildLegalLinks(BuildContext context) {
    final links = [
      {'text': 'Support', 'url': 'https://citris-quest.notion.site/support?source=copy_link'},
      {'text': 'Privacy Policy', 'url': 'https://citris-quest.notion.site/privacy-policy?source=copy_link'},
      {'text': 'Terms', 'url': 'https://citris-quest.notion.site/terms-and-conditions?source=copy_link'},
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 12,
      children: links.map((link) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchUrl(link['url']!),
          // Ensure minimum 44x44px touch target (Apple HIG standard)
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),
            child: Text(
              link['text']!,
              style: GoogleFonts.tiny5(
                fontSize: 14,
                color: AppTheme.cyanAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildCopyright(BuildContext context) {
    return Text(
      '© 2025 CITRIS Quest. Built with Flutter.',
      style: GoogleFonts.tiny5(
        fontSize: 14,
        color: Colors.white.withValues(alpha: 0.5),
      ),
      textAlign: Breakpoints.isMobile(context) ? TextAlign.center : TextAlign.right,
    );
  }
}
