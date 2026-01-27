import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wrapper widget that animates its child when it enters the viewport
/// Fade-in with upward slide animation, plays once per session
class AnimatedOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double slideDistance;
  final Duration delay;
  final Curve curve;

  const AnimatedOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.slideDistance = 40.0,
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
  });

  @override
  State<AnimatedOnScroll> createState() => _AnimatedOnScrollState();
}

class _AnimatedOnScrollState extends State<AnimatedOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Opacity animation: 0% → 100%
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    // Slide animation: slides up from slideDistance to 0
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideDistance / 100), // Convert to relative offset
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Trigger animation when 20% of element is visible (prevents animations firing too early)
    if (!_hasAnimated && info.visibleFraction >= 0.2) {
      _hasAnimated = true;

      // Add delay before starting animation
      if (widget.delay > Duration.zero) {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      } else {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated_on_scroll_${widget.child.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Wrapper for staggered child animations
/// Used for card grids where each child animates with a delay
class StaggeredAnimatedChildren extends StatelessWidget {
  final List<Widget> children;
  final Duration baseDelay;
  final Duration staggerDelay;
  final Duration duration;
  final double slideDistance;

  const StaggeredAnimatedChildren({
    super.key,
    required this.children,
    this.baseDelay = Duration.zero,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 600),
    this.slideDistance = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;

        return AnimatedOnScroll(
          duration: duration,
          slideDistance: slideDistance,
          delay: baseDelay + (staggerDelay * index),
          child: child,
        );
      }).toList(),
    );
  }
}
