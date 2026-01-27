import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../widgets/common/animated_starfield.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/how_to_play_section.dart';
import '../widgets/sections/download_section.dart';
import '../widgets/sections/contribute_section.dart';
import '../widgets/sections/credits_section.dart';
import '../widgets/sections/footer_section.dart';

/// Main landing page with all sections
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedStarfield(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section (full viewport height)
              const HeroSection(),

              // About CITRIS Section
              SizedBox(height: Breakpoints.sectionSpacing(context)),
              const AboutSection(),

              // How to Play Section
              SizedBox(height: Breakpoints.sectionSpacing(context)),
              const HowToPlaySection(),

              // Download Section
              SizedBox(height: Breakpoints.sectionSpacing(context)),
              const DownloadSection(),

              // Contribute Section
              SizedBox(height: Breakpoints.sectionSpacing(context)),
              const ContributeSection(),

              // Credits Section
              SizedBox(height: Breakpoints.sectionSpacing(context)),
              const CreditsSection(),

              // Footer
              SizedBox(height: Breakpoints.sectionSpacing(context)),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
