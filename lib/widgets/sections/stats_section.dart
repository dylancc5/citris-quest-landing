import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../../services/stats_service.dart';
import '../common/animated_counter.dart';
import '../common/hover_lift_card.dart';

/// Live statistics section showing total scans and active players
/// Displays animated counters with icons
class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  final _statsService = StatsService();
  bool _isLoading = true;
  int _totalScans = 0;
  int _totalUsers = 0;
  int? _hoveredCard;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final stats = await _statsService.getAllStats();
      if (mounted) {
        setState(() {
          _totalScans = stats['totalScans'] ?? 0;
          _totalUsers = stats['totalUsers'] ?? 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      // If error, show zeros
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: Column(
        children: [
          // Section title
          Text(
            'BY THE NUMBERS',
            style: GoogleFonts.tiny5(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppTheme.cyanAccent,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Stats cards
          Breakpoints.isMobile(context)
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: _buildStatCard(
            cardIndex: 0,
            icon: Icons.people,
            value: _totalUsers,
            label: 'ACTIVE PLAYERS',
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: _buildStatCard(
            cardIndex: 1,
            icon: Icons.photo_camera,
            value: _totalScans,
            label: 'SCANS COMPLETED',
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: _buildStatCard(
              cardIndex: 0,
              icon: Icons.people,
              value: _totalUsers,
              label: 'ACTIVE PLAYERS',
            ),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 1,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: _buildStatCard(
              cardIndex: 1,
              icon: Icons.photo_camera,
              value: _totalScans,
              label: 'SCANS COMPLETED',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required int cardIndex,
    required IconData icon,
    required int value,
    required String label,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCard = cardIndex),
      onExit: (_) => setState(() => _hoveredCard = null),
      child: HoverLiftCard(
        liftDistance: 8,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.backgroundSecondary,
                AppTheme.backgroundTertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: AppTheme.cyanAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.cyanAccent.withValues(alpha: _hoveredCard == cardIndex ? 0.6 : 0.4),
                blurRadius: _hoveredCard == cardIndex ? 60 : 40,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            icon,
            size: 48,
            color: AppTheme.cyanAccent,
          ),
          const SizedBox(height: 24),

          // Animated counter
          _isLoading
              ? Text(
                  '---',
                  style: GoogleFonts.tiny5(
                    fontSize: Breakpoints.responsive<double>(
                      context,
                      mobile: 28,
                      tablet: 36,
                      desktop: 48,
                    ),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              : AnimatedCounter(
                  targetValue: value,
                  duration: const Duration(milliseconds: 1000),
                  style: GoogleFonts.tiny5(
                    fontSize: Breakpoints.responsive<double>(
                      context,
                      mobile: 28,
                      tablet: 36,
                      desktop: 48,
                    ),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
          const SizedBox(height: 16),

          // Label
          Text(
            label,
            style: GoogleFonts.tiny5(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: AppTheme.cyanAccent,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
        ),
      ),
    );
  }
}
