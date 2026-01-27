import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../../painters/space_invader_painter.dart';
import '../common/primary_button.dart';

/// Hero section with animated Space Invader and CTA
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

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

  Future<void> _launchTestFlight() async {
    final url = Uri.parse('https://testflight.apple.com/join/QSQXHdqH');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
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
                height: 120,
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
        // CTA Button
        PrimaryButton(
          text: 'Download on TestFlight',
          onPressed: _launchTestFlight,
          width: 280,
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
                onPressed: _launchTestFlight,
                width: 300,
                height: 70,
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
    final fontSize = Breakpoints.responsive<double>(
      context,
      mobile: 28,
      tablet: 36,
      desktop: 48,
    );

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [AppTheme.cyanAccent, AppTheme.bluePrimary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        'Celebrating 25 Years of CITRIS Innovation',
        style: TextStyle(
          fontFamily: 'Silkscreen',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.3,
          shadows: [
            Shadow(
              color: AppTheme.cyanAccent.withValues(alpha: 0.4),
              blurRadius: 20,
            ),
          ],
        ),
        textAlign: Breakpoints.isMobile(context) || Breakpoints.isTablet(context)
            ? TextAlign.center
            : TextAlign.left,
      ),
    );
  }

  Widget _buildSubheadline(BuildContext context) {
    final fontSize = Breakpoints.responsive<double>(
      context,
      mobile: 18,
      tablet: 20,
      desktop: 24,
    );

    return Text(
      'Scan artwork. Collect memories. Compete with the community.',
      style: GoogleFonts.tiny5(
        fontSize: fontSize,
        color: Colors.white.withValues(alpha: 0.7),
        fontWeight: FontWeight.w400,
      ),
      textAlign: Breakpoints.isMobile(context) || Breakpoints.isTablet(context)
          ? TextAlign.center
          : TextAlign.left,
    );
  }
}
