import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../common/primary_button.dart';

/// Download section with TestFlight CTA
class DownloadSection extends StatelessWidget {
  const DownloadSection({super.key});

  Future<void> _launchTestFlight() async {
    final url = Uri.parse('https://testflight.apple.com/join/QSQXHdqH');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: Column(
        children: [
          // Headline
          Text(
            'JOIN THE BETA',
            style: GoogleFonts.silkscreen(
              fontSize: Breakpoints.responsive<double>(
                context,
                mobile: 28,
                tablet: 32,
                desktop: 36,
              ),
              color: AppTheme.cyanAccent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          // Body text
          Text(
            'CITRIS Quest is currently in beta testing on iOS. Download TestFlight and join the adventure. Your feedback helps shape the future of the game.',
            style: GoogleFonts.tiny5(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // Instructions
          ...List.generate(4, (index) {
            final steps = [
              'Download TestFlight from the App Store',
              'Tap the invite link below',
              'Install CITRIS Quest beta',
              'Start scanning!',
            ];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.cyanAccent, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.tiny5(
                          fontSize: 16,
                          color: AppTheme.cyanAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      steps[index],
                      style: GoogleFonts.tiny5(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 40),
          // CTA Button
          PrimaryButton(
            text: 'Open TestFlight Invite',
            onPressed: _launchTestFlight,
            width: 300,
            height: 60,
          ),
        ],
      ),
    );
  }
}
