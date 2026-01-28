import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../../painters/space_invader_painter.dart';
import '../common/primary_button.dart';
import '../common/pulsing_glow_text.dart';

/// Hero section with animated Space Invader and CTA
class HeroSection extends StatefulWidget {
  final VoidCallback? onLearnMoreTap;
  final VoidCallback? onDownloadTap;

  const HeroSection({super.key, this.onLearnMoreTap, this.onDownloadTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -8.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  void _handleDownloadTap() {
    widget.onDownloadTap?.call();
  }

  void _scrollToHowToPlay() {
    widget.onLearnMoreTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = Breakpoints.isMobile(context);
    final isTablet = Breakpoints.isTablet(context);

    return Container(
      height: screenHeight,
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: isMobile || isTablet
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Floating Space Invader
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimation.value),
              child: SizedBox(
                width: 120,
                height: 120 * (8 / 11), // Maintain 11:8 aspect ratio
                child: CustomPaint(
                  painter: SpaceInvaderPainter(
                    color: AppTheme.cyanAccent,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 40),
        // Headline
        _buildHeadline(context),
        const SizedBox(height: 24),
        // Subheadline
        _buildSubheadline(context),
        const SizedBox(height: 40),
        // Primary CTA Button
        PrimaryButton(
          text: 'Download on TestFlight',
          onPressed: _handleDownloadTap,
          width: 320,
          height: 70,
        ),
        const SizedBox(height: 24),
        // Secondary "Learn More" Button
        PrimaryButton(
          text: 'Learn More',
          onPressed: _scrollToHowToPlay,
          width: 320,
          height: 70,
          borderColor: AppTheme.magentaPrimary,
          textColor: AppTheme.magentaPrimary,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        // Left side: Text content
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadline(context),
              const SizedBox(height: 32),
              _buildSubheadline(context),
              const SizedBox(height: 48),
              PrimaryButton(
                text: 'Download on TestFlight',
                onPressed: _handleDownloadTap,
                width: 350,
                height: 75,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Learn More',
                onPressed: _scrollToHowToPlay,
                width: 350,
                height: 75,
                borderColor: AppTheme.magentaPrimary,
                textColor: AppTheme.magentaPrimary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 80),
        // Right side: Floating Space Invader
        Expanded(
          flex: 2,
          child: AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: SizedBox(
                  width: screenWidth * 0.25,
                  height: screenWidth * 0.25,
                  child: CustomPaint(
                    painter: SpaceInvaderPainter(
                      color: AppTheme.cyanAccent,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeadline(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final isTablet = Breakpoints.isTablet(context);

    return Column(
      crossAxisAlignment: isMobile || isTablet
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // "CITRIS QUEST" title with pulsing glow
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppTheme.cyanAccent, AppTheme.bluePrimary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: PulsingGlowText(
            text: 'CITRIS QUEST',
            style: GoogleFonts.tiny5(
              fontSize: Breakpoints.responsive<double>(
                context,
                mobile: 40,  // Increased from 64px
                tablet: 52,  // Increased from 84px
                desktop: 64, // Increased from 120px
              ),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
            glowColor: AppTheme.cyanAccent,
            minGlowBlur: 30.0,
            maxGlowBlur: 50.0,
            pulseDuration: const Duration(seconds: 3),
            textAlign: isMobile || isTablet
                ? TextAlign.center
                : TextAlign.left,
          ),
        ),
        const SizedBox(height: 24),
        // "Celebrating 25 Years..." subtitle with improved contrast
        Text(
          'Celebrating 25 Years of CITRIS Innovation',
          style: GoogleFonts.tiny5(
            fontSize: Breakpoints.responsive<double>(
              context,
              mobile: 20,  // Increased from 18pt
              tablet: 22,  // Increased from 20pt
              desktop: 24, // Same as before
            ),
            fontWeight: FontWeight.w400,
            color: AppTheme.bluePrimary,
            height: 1.4,  // Increased line-height for breathing room
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 2,
              ),
            ],
          ),
          textAlign: isMobile || isTablet
              ? TextAlign.center
              : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildSubheadline(BuildContext context) {
    final fontSize = Breakpoints.responsive<double>(
      context,
      mobile: 18,  // Increased from 15pt
      tablet: 19,  // Increased from 17pt
      desktop: 20, // Same as before
    );

    return Padding(
      padding: const EdgeInsets.only(top: 32), // Increased spacing from subtitle
      child: Text(
        'Scan artwork. Collect memories. Compete with the community.',
        style: GoogleFonts.tiny5(
          fontSize: fontSize,
          color: Colors.white,  // Boosted from 70% to 100% opacity
          fontWeight: FontWeight.w400,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 2,
            ),
          ],
        ),
        textAlign: Breakpoints.isMobile(context) || Breakpoints.isTablet(context)
            ? TextAlign.center
            : TextAlign.left,
      ),
    );
  }
}
