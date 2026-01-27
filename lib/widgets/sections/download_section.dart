import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../common/primary_button.dart';
import '../common/pixelated_qr_code.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1000,
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
          const SizedBox(height: 60),

          // QR Code + Instructions Layout (responsive)
          if (isMobile)
            // Mobile: Stacked layout
            Column(
              children: [
                // QR Code on top
                PixelatedQrCode(
                  data: 'https://testflight.apple.com/join/QSQXHdqH',
                  size: 200,
                  label: 'SCAN TO DOWNLOAD',
                ),
                const SizedBox(height: 48),
                // Instructions below
                _buildInstructions(),
              ],
            )
          else
            // Desktop: Side-by-side layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions on left
                Expanded(
                  child: _buildInstructions(),
                ),
                const SizedBox(width: 48),
                // QR Code on right
                PixelatedQrCode(
                  data: 'https://testflight.apple.com/join/QSQXHdqH',
                  size: 240,
                  label: 'SCAN TO DOWNLOAD',
                ),
              ],
            ),

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

  Widget _buildInstructions() {
    final steps = [
      'Download TestFlight from the App Store',
      'Tap the invite link or scan the QR code',
      'Install CITRIS Quest beta',
      'Start scanning!',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
