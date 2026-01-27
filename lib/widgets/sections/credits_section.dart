import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';

/// Credits section with team acknowledgments
class CreditsSection extends StatelessWidget {
  const CreditsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Breakpoints.maxContentWidth(context)),
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'CREDITS',
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
          _buildCreditsGrid(context),
        ],
      ),
    );
  }

  Widget _buildCreditsGrid(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final isTablet = Breakpoints.isTablet(context);

    final credits = [
      {'title': 'Development', 'items': ['CITRIS Quest Team', 'UC Berkeley CITRIS']},
      {'title': 'Machine Learning', 'items': ['HuggingFace Spaces', 'TensorFlow Team']},
      {'title': 'Open Source', 'items': ['Flutter', 'Supabase', 'Google Fonts']},
    ];

    if (isMobile) {
      return Column(
        children: credits.map((cat) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildCreditCard(cat['title'] as String, cat['items'] as List<String>),
        )).toList(),
      );
    } else if (isTablet) {
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        children: credits.map((cat) => SizedBox(
          width: (MediaQuery.of(context).size.width - Breakpoints.horizontalPadding(context) * 2 - 24) / 2,
          child: _buildCreditCard(cat['title'] as String, cat['items'] as List<String>),
        )).toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: credits.map((cat) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildCreditCard(cat['title'] as String, cat['items'] as List<String>),
          ),
        )).toList(),
      );
    }
  }

  Widget _buildCreditCard(String title, List<String> items) {
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
        border: Border.all(color: AppTheme.cyanAccent, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cyanAccent.withValues(alpha: 0.3),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.tiny5(
              fontSize: 20,
              color: AppTheme.cyanAccent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              item,
              style: GoogleFonts.tiny5(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
