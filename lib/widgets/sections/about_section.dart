import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../../painters/pixelated_circle_painter.dart';

/// About CITRIS section with 25th anniversary badge
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: Breakpoints.maxContentWidth(context),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAnniversaryBadge(context),
        const SizedBox(height: 32),
        _buildAboutText(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Anniversary badge
        Expanded(
          flex: 2,
          child: Center(child: _buildAnniversaryBadge(context)),
        ),
        const SizedBox(width: 80),
        // Right: About text
        Expanded(
          flex: 3,
          child: _buildAboutText(context),
        ),
      ],
    );
  }

  Widget _buildAnniversaryBadge(BuildContext context) {
    final size = Breakpoints.responsive<double>(
      context,
      mobile: 150,
      tablet: 180,
      desktop: 220,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.yellowPrimary,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cyanAccent.withValues(alpha: 0.5),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: CustomPaint(
        painter: PixelatedCirclePainter(
          color: AppTheme.yellowPrimary,
          pixelSize: 2,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '25',
                style: GoogleFonts.tiny5(
                  fontSize: size * 0.35,
                  color: AppTheme.yellowPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'YEARS',
                style: GoogleFonts.tiny5(
                  fontSize: size * 0.12,
                  color: AppTheme.cyanAccent,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    final fontSize = Breakpoints.responsive<double>(
      context,
      mobile: 16,
      tablet: 17,
      desktop: 18,
    );

    return RichText(
      textAlign: Breakpoints.isMobile(context) ? TextAlign.center : TextAlign.left,
      text: TextSpan(
        style: GoogleFonts.tiny5(
          fontSize: fontSize,
          color: Colors.white.withValues(alpha: 0.85),
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        children: [
          const TextSpan(text: 'CITRIS Quest celebrates '),
          TextSpan(
            text: '25 years of innovation',
            style: TextStyle(color: AppTheme.bluePrimary),
          ),
          const TextSpan(
            text: ' at the Center for Information Technology Research in the Interest of Society. This location-based mobile game transforms campus artwork into interactive collectibles. Scan physical art pieces using your camera, earn XP and coins, unlock achievements, and compete on the global leaderboard.',
          ),
        ],
      ),
    );
  }
}
