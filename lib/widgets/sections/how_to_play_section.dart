import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';

/// How to Play section with 4-step guide
class HowToPlaySection extends StatelessWidget {
  const HowToPlaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Breakpoints.maxContentWidth(context),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: Column(
        children: [
          // Section title
          Text(
            'HOW TO PLAY',
            style: GoogleFonts.tiny5(
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
          SizedBox(height: Breakpoints.responsive<double>(
            context,
            mobile: 32,
            tablet: 48,
            desktop: 64,
          )),
          // Steps grid
          _buildStepsGrid(context),
        ],
      ),
    );
  }

  Widget _buildStepsGrid(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final isTablet = Breakpoints.isTablet(context);

    if (isMobile) {
      return Column(
        children: [
          _buildStep(context, 1, 'Scan Artwork',
            'Use your camera to scan physical artwork on campus',
            Icons.photo_camera, AppTheme.cyanAccent),
          SizedBox(height: Breakpoints.cardSpacing(context)),
          _buildStep(context, 2, 'Verify Location',
            'GPS validates you\'re within range of the artwork',
            Icons.location_on, AppTheme.magentaPrimary),
          SizedBox(height: Breakpoints.cardSpacing(context)),
          _buildStep(context, 3, 'Earn Rewards',
            'Collect XP, coins, and unlock achievements',
            Icons.stars, AppTheme.yellowPrimary),
          SizedBox(height: Breakpoints.cardSpacing(context)),
          _buildStep(context, 4, 'Compete',
            'Climb the leaderboard and challenge friends',
            Icons.emoji_events, AppTheme.greenPrimary),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildStep(context, 1, 'Scan Artwork',
                'Use your camera to scan physical artwork on campus',
                Icons.photo_camera, AppTheme.cyanAccent)),
              SizedBox(width: Breakpoints.cardSpacing(context)),
              Expanded(child: _buildStep(context, 2, 'Verify Location',
                'GPS validates you\'re within range of the artwork',
                Icons.location_on, AppTheme.magentaPrimary)),
            ],
          ),
          SizedBox(height: Breakpoints.cardSpacing(context)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildStep(context, 3, 'Earn Rewards',
                'Collect XP, coins, and unlock achievements',
                Icons.stars, AppTheme.yellowPrimary)),
              SizedBox(width: Breakpoints.cardSpacing(context)),
              Expanded(child: _buildStep(context, 4, 'Compete',
                'Climb the leaderboard and challenge friends',
                Icons.emoji_events, AppTheme.greenPrimary)),
            ],
          ),
        ],
      );
    } else {
      // Desktop: 4 columns
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildStep(context, 1, 'Scan Artwork',
            'Use your camera to scan physical artwork on campus',
            Icons.photo_camera, AppTheme.cyanAccent)),
          SizedBox(width: Breakpoints.cardSpacing(context)),
          Expanded(child: _buildStep(context, 2, 'Verify Location',
            'GPS validates you\'re within range of the artwork',
            Icons.location_on, AppTheme.magentaPrimary)),
          SizedBox(width: Breakpoints.cardSpacing(context)),
          Expanded(child: _buildStep(context, 3, 'Earn Rewards',
            'Collect XP, coins, and unlock achievements',
            Icons.stars, AppTheme.yellowPrimary)),
          SizedBox(width: Breakpoints.cardSpacing(context)),
          Expanded(child: _buildStep(context, 4, 'Compete',
            'Climb the leaderboard and challenge friends',
            Icons.emoji_events, AppTheme.greenPrimary)),
        ],
      );
    }
  }

  Widget _buildStep(BuildContext context, int number, String title,
      String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0f1a2e),
            const Color(0xFF16213e),
            const Color(0xFF1a2542),
          ],
        ),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number + icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'STEP $number',
                  style: GoogleFonts.tiny5(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(icon, color: color, size: 32),
            ],
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            title.toUpperCase(),
            style: GoogleFonts.tiny5(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            description,
            style: GoogleFonts.tiny5(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Placeholder for screenshot
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppTheme.backgroundPrimary,
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined, color: color.withValues(alpha: 0.3), size: 48),
                  const SizedBox(height: 8),
                  Text(
                    'Game Screenshot\nComing Soon',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tiny5(
                      fontSize: 12,
                      color: color.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
