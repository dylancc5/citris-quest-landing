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
      constraints:
          BoxConstraints(maxWidth: Breakpoints.maxContentWidth(context)),
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
          SizedBox(
              height: Breakpoints.responsive<double>(
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
          {
            'role': 'Product Lead',
            'roleColor': AppTheme.bluePrimary,
            'names': ['Dylan Chen']
          },
          {
            'role': 'Computer Vision Engineers',
            'roleColor': AppTheme.cyanAccent,
            'names': ['Dylan Chen', 'William Su']
          },
          {
            'role': 'UX/UI Designer',
            'roleColor': AppTheme.magentaPrimary,
            'names': ['Dylan Chen']
          },
          {
            'role': 'Product Designers',
            'roleColor': AppTheme.yellowPrimary,
            'names': ['Dylan Chen', 'Madeline Louise Aguilera']
          },
          {
            'role': 'Quality Assurance',
            'roleColor': AppTheme.redPrimary,
            'names': ['Dylan Chen']
          },
        ]
      },
      {
        'title': 'Creative Team',
        'items': [
          {
            'role': 'Pixel Artists',
            'roleColor': AppTheme.magentaPrimary,
            'names': [
              'William Su',
              'Zachary Weible',
              'Luca Angelidis',
              'Dylan Chen'
            ]
          },
          {
            'role': 'Game Designers',
            'roleColor': AppTheme.yellowPrimary,
            'names': ['Dylan Chen', 'Samuel Jeyapaul', 'Joshua Lee']
          },
          {
            'role': '3D CAD Artists',
            'roleColor': AppTheme.greenPrimary,
            'names': ['Stanley Fong', 'Dylan Chen']
          },
        ]
      },
      {
        'title': 'Legal & Compliance',
        'items': [
          {
            'role': 'Legal Contributor',
            'roleColor': AppTheme.orangePrimary,
            'names': ['Lucy Zhao']
          },
        ]
      },
      {
        'title': 'Technology Partners',
        'items': [
          {
            'role': 'Project Sponsor',
            'roleColor': AppTheme.bluePrimary,
            'names': ['CITRIS & Banatao Institute']
          },
          {
            'role': 'Backend',
            'roleColor': AppTheme.cyanAccent,
            'names': ['Supabase']
          },
          {
            'role': 'ML Hosting',
            'roleColor': AppTheme.greenPrimary,
            'names': ['Hugging Face']
          },
          {
            'role': 'Typography',
            'roleColor': AppTheme.magentaPrimary,
            'names': ['Google Fonts']
          },
          {
            'role': 'Framework',
            'roleColor': AppTheme.yellowPrimary,
            'names': ['Flutter']
          },
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
            child: SizedBox(
              width: double.infinity,
              child: _buildCreditCard(index, cat['title'] as String,
                  cat['items'] as List<Map<String, dynamic>>),
            ),
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
                  Breakpoints.horizontalPadding(context) * 2 -
                  24) /
              2;
          return SizedBox(
            width: cardWidth,
            child: _buildCreditCard(index, cat['title'] as String,
                cat['items'] as List<Map<String, dynamic>>),
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
              child: _buildCreditCard(index, cat['title'] as String,
                  cat['items'] as List<Map<String, dynamic>>),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildCreditCard(
      int cardIndex, String title, List<Map<String, dynamic>> items) {
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
                color: AppTheme.cyanAccent
                    .withValues(alpha: _hoveredCard == cardIndex ? 0.5 : 0.3),
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
              ...items.expand((item) => [
                    // Role header
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        (item['role'] as String).toUpperCase(),
                        style: GoogleFonts.tiny5(
                          fontSize: 14,
                          color: item['roleColor'] as Color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Names list
                    ...(item['names'] as List<String>).map((name) => Padding(
                          padding: const EdgeInsets.only(bottom: 6, left: 12),
                          child: Text(
                            name,
                            style: GoogleFonts.tiny5(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        )),
                    // Spacing between role groups
                    const SizedBox(height: 8),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
