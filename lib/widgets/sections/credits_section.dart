import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../common/hover_lift_card.dart';

/// Credits section with team acknowledgments
class CreditsSection extends StatefulWidget {
  const CreditsSection({super.key});

  @override
  State<CreditsSection> createState() => _CreditsSectionState();
}

class _CreditsSectionState extends State<CreditsSection> {
  int? _hoveredCard;

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
      {
        'title': 'Development Team',
        'items': [
          'Product Lead & Full-Stack Dev: Dylan Chen',
          'Computer Vision Engineer: Dylan Chen',
          'CV Research Assistant: William Su',
          'UX/UI Designer: Dylan Chen',
          'Product Design: Madeline Louise Aguilera',
          'Quality Assurance: Dylan Chen',
        ]
      },
      {
        'title': 'Creative Team',
        'items': [
          'Pixel Artist: William Su',
          'Pixel Artist: Zachary Weible',
          'Pixel Artist: Luca Angelidis',
          'Pixel Artist: Dylan Chen',
          'Game Designer: Samuel Jeyapaul',
          'Game Designer: Joshua Lee',
          'Game Designer: Dylan Chen',
          '3D CAD Artist: Stanley Fong',
          '3D CAD Artist: Dylan Chen',
        ]
      },
      {
        'title': 'Legal & Compliance',
        'items': [
          'Legal Contributor: Lucy Zhao',
        ]
      },
      {
        'title': 'Technology Partners',
        'items': [
          'Project Sponsor: CITRIS & Banatao Institute',
          'Backend: Supabase',
          'ML Hosting: Hugging Face',
          'Typography: Google Fonts',
          'Framework: Flutter',
        ]
      },
    ];

    if (isMobile) {
      return Column(
        children: credits.asMap().entries.map((entry) {
          final index = entry.key;
          final cat = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildCreditCard(index, cat['title'] as String, cat['items'] as List<String>),
          );
        }).toList(),
      );
    } else if (isTablet) {
      // Tablet: 2 columns
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        children: credits.asMap().entries.map((entry) {
          final index = entry.key;
          final cat = entry.value;
          final cardWidth = (MediaQuery.of(context).size.width -
            Breakpoints.horizontalPadding(context) * 2 - 24) / 2;
          return SizedBox(
            width: cardWidth,
            child: _buildCreditCard(index, cat['title'] as String, cat['items'] as List<String>),
          );
        }).toList(),
      );
    } else {
      // Desktop: 4 columns in one row
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: credits.asMap().entries.map((entry) {
          final index = entry.key;
          final cat = entry.value;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildCreditCard(index, cat['title'] as String, cat['items'] as List<String>),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildCreditCard(int cardIndex, String title, List<String> items) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCard = cardIndex),
      onExit: (_) => setState(() => _hoveredCard = null),
      child: HoverLiftCard(
        liftDistance: 8,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
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
                color: AppTheme.cyanAccent.withValues(alpha: _hoveredCard == cardIndex ? 0.5 : 0.3),
                blurRadius: _hoveredCard == cardIndex ? 25 : 12,
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
        ),
      ),
    );
  }
}
