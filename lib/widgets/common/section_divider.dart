import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';

/// Gentle horizontal divider between sections
/// Matches retro pixel aesthetic with cyan glow effect
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive width based on screen size
    final width = Breakpoints.isMobile(context)
        ? 0.6 // 60% on mobile
        : Breakpoints.isTablet(context)
            ? 0.7 // 70% on tablet
            : 0.8; // 80% on desktop

    // Responsive vertical margin
    final verticalMargin =
        Breakpoints.isMobile(context) ? 40.0 : 60.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: width,
        child: Container(
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppTheme.cyanAccent.withValues(alpha: 0.6),
                AppTheme.cyanAccent.withValues(alpha: 0.8),
                AppTheme.cyanAccent.withValues(alpha: 0.6),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.cyanAccent.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
