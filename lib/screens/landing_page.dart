import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../widgets/common/animated_starfield.dart';
import '../widgets/navigation/sticky_nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/stats_section.dart';
import '../widgets/sections/how_to_play_section.dart';
import '../widgets/sections/download_section.dart';
import '../widgets/sections/contribute_section.dart';
import '../widgets/sections/faq_section.dart';
import '../widgets/sections/credits_section.dart';
import '../widgets/sections/footer_section.dart';

/// Main landing page with all sections
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _howToPlayKey = GlobalKey();
  final GlobalKey _downloadKey = GlobalKey();
  final GlobalKey _contributeKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _creditsKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    switch (section) {
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'how_to_play':
        targetKey = _howToPlayKey;
        break;
      case 'download':
        targetKey = _downloadKey;
        break;
      case 'contribute':
        targetKey = _contributeKey;
        break;
      case 'faq':
        targetKey = _faqKey;
        break;
      case 'credits':
        targetKey = _creditsKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      final RenderBox? renderBox =
          targetKey!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        _scrollController.animateTo(
          position.dy + _scrollController.offset - 100, // Offset for nav bar
          duration: const Duration(milliseconds: 1200), // Longer duration for smoother scroll
          curve: Curves.easeInOutCubic, // Smoother cubic easing
        );
      }
    }
  }

  void _scrollToDownload() {
    _scrollToSection('download');
  }

  void _scrollToHowToPlay() {
    _scrollToSection('how_to_play');
  }

  @override
  Widget build(BuildContext context) {
    // Optimize particle density for mobile devices
    final screenWidth = MediaQuery.of(context).size.width;
    final particleDensity = screenWidth < 600 ? 0.5 : 1.0; // 50% particles on mobile
    final heroHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Main content with starfield background
          AnimatedStarfield(
            particleDensity: particleDensity,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section (full viewport height)
                  HeroSection(
                    key: _heroKey,
                    onLearnMoreTap: _scrollToHowToPlay,
                    onDownloadTap: _scrollToDownload,
                  ),

                  // About CITRIS Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  AboutSection(key: _aboutKey),

                  // Live Stats Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  const StatsSection(),

                  // How to Play Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  HowToPlaySection(key: _howToPlayKey),

                  // Download Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  DownloadSection(key: _downloadKey),

                  // Contribute Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  ContributeSection(key: _contributeKey),

                  // FAQ Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  FaqSection(key: _faqKey),

                  // Credits Section
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  CreditsSection(key: _creditsKey),

                  // Footer
                  SizedBox(height: Breakpoints.sectionSpacing(context)),
                  const FooterSection(),
                ],
              ),
            ),
          ),

          // Sticky navigation bar with integrated progress bar
          StickyNavBar(
            scrollController: _scrollController,
            heroHeight: heroHeight,
            onDownloadTap: _scrollToDownload,
            onNavLinkTap: _scrollToSection,
            sectionKeys: {
              'about': _aboutKey,
              'how_to_play': _howToPlayKey,
              'download': _downloadKey,
              'contribute': _contributeKey,
              'faq': _faqKey,
              'credits': _creditsKey,
            },
          ),
        ],
      ),
    );
  }
}
