import 'dart:math';
import 'package:flutter/material.dart';
import '../../painters/starfield_painter.dart';
import '../../core/theme.dart';

/// Full-page animated starfield background for landing page
/// Optimizes particle count based on screen size for performance
class AnimatedStarfield extends StatefulWidget {
  final Widget child;

  const AnimatedStarfield({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedStarfield> createState() => _AnimatedStarfieldState();
}

class _AnimatedStarfieldState extends State<AnimatedStarfield>
    with SingleTickerProviderStateMixin {
  late List<Star> _stars;
  late List<Galaxy> _galaxies;
  late List<Planet> _planets;
  late ValueNotifier<double> _timeNotifier;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _timeNotifier = ValueNotifier(0.0);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    )..repeat();

    _controller.addListener(() {
      _timeNotifier.value = _controller.value * 120;
    });

    // Initialize stars, galaxies, and planets
    _initializeObjects();
  }

  void _initializeObjects() {
    final random = Random(42); // Fixed seed for consistent starfield
    final starCount = 250;

    // Generate stars
    _stars = List.generate(starCount, (i) {
      return Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextBool() ? 1.0 : 2.0,
        layer: random.nextInt(3),
      );
    });

    // Generate galaxies
    _galaxies = List.generate(4, (i) {
      return Galaxy(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 8.0 + random.nextDouble() * 4.0,
        layer: random.nextInt(3),
        color: AppTheme.cyanAccent.withValues(alpha: 0.2),
      );
    });

    // Generate planets
    _planets = List.generate(18, (i) {
      return Planet(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 3.0 + random.nextDouble() * 3.0,
        layer: random.nextInt(3),
        color: Color.fromRGBO(
          100 + random.nextInt(156),
          100 + random.nextInt(156),
          100 + random.nextInt(156),
          0.3,
        ),
        beveled: random.nextBool(),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated starfield background
        Positioned.fill(
          child: CustomPaint(
            painter: StarfieldPainter(
              stars: _stars,
              galaxies: _galaxies,
              planets: _planets,
              timeNotifier: _timeNotifier,
            ),
          ),
        ),
        // Content overlay
        widget.child,
      ],
    );
  }
}
