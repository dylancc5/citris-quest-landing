import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../../painters/space_invader_painter.dart';
import '../../ui/painters/segmented_progress_painter.dart';
import '../common/primary_button.dart';
import 'hamburger_menu_overlay.dart';

/// Sticky navigation bar that appears after scrolling past hero section
/// Desktop: Logo left, nav links center, CTA right
/// Mobile: Logo left, hamburger menu right
class StickyNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final double heroHeight;
  final VoidCallback onDownloadTap;
  final Function(String) onNavLinkTap;
  final Map<String, GlobalKey> sectionKeys;

  const StickyNavBar({
    super.key,
    required this.scrollController,
    required this.heroHeight,
    required this.onDownloadTap,
    required this.onNavLinkTap,
    required this.sectionKeys,
  });

  @override
  State<StickyNavBar> createState() => _StickyNavBarState();
}

class _StickyNavBarState extends State<StickyNavBar> {
  bool _isVisible = false;
  bool _isMenuOpen = false;
  String _activeSection = 'about'; // Default to "about"
  double _scrollProgress = 0.0;

  final List<Map<String, String>> _navLinks = const [
    {'label': 'About', 'section': 'about'},
    {'label': 'How to Play', 'section': 'how_to_play'},
    {'label': 'Download', 'section': 'download'},
    {'label': 'Contribute', 'section': 'contribute'},
    {'label': 'FAQ', 'section': 'faq'},
    {'label': 'Credits', 'section': 'credits'},
  ];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;

    final offset = widget.scrollController.offset;
    final maxScroll = widget.scrollController.position.maxScrollExtent;

    // Calculate scroll progress
    final newProgress = maxScroll > 0 ? (offset / maxScroll).clamp(0.0, 1.0) : 0.0;

    // Show nav bar after scrolling past hero section
    final shouldBeVisible = offset > widget.heroHeight * 0.8;

    // Only update if progress changed significantly (reduces repaints)
    if (shouldBeVisible != _isVisible || (newProgress - _scrollProgress).abs() > 0.001) {
      setState(() {
        _isVisible = shouldBeVisible;
        _scrollProgress = newProgress;
      });
    }

    // Update active section based on scroll position
    // This will be implemented more robustly with section keys later
    _updateActiveSection(offset);
  }

  void _updateActiveSection(double offset) {
    if (!widget.scrollController.hasClients) return;

    // Calculate actual section positions from RenderBox
    final sectionPositions = <String, double>{};

    widget.sectionKeys.forEach((section, key) {
      if (key.currentContext != null) {
        final RenderBox? box = key.currentContext!.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          // Store absolute position (position.dy is relative to viewport, add offset for absolute)
          sectionPositions[section] = position.dy + offset;
        }
      }
    });

    // Sort sections by position
    final sortedSections = sectionPositions.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Determine active section based on current scroll + nav bar offset (100px)
    final viewportTop = offset + 100; // Account for nav bar height

    String newActive = 'about'; // Default fallback

    // Find the last section whose start position is before viewport top
    for (var entry in sortedSections) {
      if (entry.value <= viewportTop) {
        newActive = entry.key;
      } else {
        break;
      }
    }

    // Special case: force "credits" when within 50px of bottom
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final isAtVeryBottom = offset >= maxScroll - 50;
    if (isAtVeryBottom) {
      newActive = 'credits';
    }

    if (newActive != _activeSection) {
      setState(() {
        _activeSection = newActive;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutCubic,
    );
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
    });
  }

  void _handleNavLinkTap(String section) {
    _closeMenu();
    widget.onNavLinkTap(section);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final segmentCount = (screenWidth / 55).round().clamp(20, 30);

    return Stack(
      children: [
        // Main nav bar
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          top: _isVisible ? 0 : -100,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.95),
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.cyanAccent,
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.cyanAccent.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main nav bar content
                Container(
                  height: isMobile ? 64 : 80,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 48,
                  ),
                  child: isMobile
                      ? _buildMobileLayout(context)
                      : _buildDesktopLayout(context),
                ),

                // Progress bar at bottom of nav bar
                SizedBox(
                  height: 4,
                  child: CustomPaint(
                    painter: SegmentedProgressPainter(
                      progress: _scrollProgress,
                      filledColor: AppTheme.cyanAccent,
                      emptyColor: Colors.white.withValues(alpha: 0.1),
                      segmentCount: segmentCount,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Mobile menu overlay (rendered outside nav bar container to prevent clipping)
        if (isMobile && _isMenuOpen)
          Positioned(
            top: _isVisible ? 68 : -100, // 64px nav bar + 4px progress bar
            left: 0,
            right: 0,
            child: HamburgerMenuOverlay(
              navLinks: _navLinks,
              activeSection: _activeSection,
              onNavLinkTap: _handleNavLinkTap,
              onDownloadTap: () {
                _closeMenu();
                widget.onDownloadTap();
              },
              onClose: _closeMenu,
            ),
          ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo (tappable, scrolls to top)
        _buildLogo(),

        // Hamburger menu icon
        _buildHamburgerIcon(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Stack(
      children: [
        // Logo (left)
        Align(
          alignment: Alignment.centerLeft,
          child: _buildLogo(),
        ),

        // Navigation links (absolute center)
        Center(
          child: _buildDesktopNavLinks(),
        ),

        // CTA button (right)
        Align(
          alignment: Alignment.centerRight,
          child: PrimaryButton(
            text: 'Join Beta',
            onPressed: widget.onDownloadTap,
            width: 120,
            height: 48,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    // Space Invader aspect ratio is 11:8 (width:height)
    const logoHeight = 32.0;
    const logoWidth = logoHeight * (11 / 8); // ~44px

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _scrollToTop,
        child: SizedBox(
          width: logoWidth,
          height: logoHeight,
          child: CustomPaint(
            painter: SpaceInvaderPainter(color: AppTheme.cyanAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildHamburgerIcon() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _toggleMenu,
        child: Container(
          width: 44,
          height: 44,
          padding: const EdgeInsets.all(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: _isMenuOpen
                ? _buildXIcon()
                : _buildHamburgerBars(),
          ),
        ),
      ),
    );
  }

  Widget _buildHamburgerBars() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return Container(
          width: 20,
          height: 2,
          decoration: BoxDecoration(
            color: AppTheme.cyanAccent,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }

  Widget _buildXIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 0.785398, // 45 degrees in radians
          child: Container(
            width: 20,
            height: 2,
            decoration: BoxDecoration(
              color: AppTheme.cyanAccent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        Transform.rotate(
          angle: -0.785398, // -45 degrees
          child: Container(
            width: 20,
            height: 2,
            decoration: BoxDecoration(
              color: AppTheme.cyanAccent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNavLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _navLinks.map((link) {
        final isActive = _activeSection == link['section'];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _handleNavLinkTap(link['section']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  link['label']!.toUpperCase(),
                  style: GoogleFonts.tiny5(
                    fontSize: 15,
                    color: isActive ? AppTheme.cyanAccent : Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
