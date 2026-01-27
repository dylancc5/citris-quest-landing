import 'package:flutter/material.dart';

/// Text widget with pulsing glow animation
/// Used for hero title to draw attention while maintaining retro aesthetic
class PulsingGlowText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color glowColor;
  final double minGlowBlur;
  final double maxGlowBlur;
  final Duration pulseDuration;
  final TextAlign? textAlign;

  const PulsingGlowText({
    super.key,
    required this.text,
    required this.style,
    required this.glowColor,
    this.minGlowBlur = 30.0,
    this.maxGlowBlur = 50.0,
    this.pulseDuration = const Duration(seconds: 3),
    this.textAlign,
  });

  @override
  State<PulsingGlowText> createState() => _PulsingGlowTextState();
}

class _PulsingGlowTextState extends State<PulsingGlowText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.pulseDuration,
    )..repeat(reverse: true);

    // Animate glow blur from min to max and back
    _glowAnimation = Tween<double>(
      begin: widget.minGlowBlur,
      end: widget.maxGlowBlur,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: widget.style.copyWith(
            shadows: [
              Shadow(
                color: widget.glowColor.withValues(alpha: 0.4),
                blurRadius: _glowAnimation.value,
              ),
              // Add a subtle black shadow for readability on starfield
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          textAlign: widget.textAlign,
        );
      },
    );
  }
}
