import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

/// Animated success/error message with slide-in animation and icon effects
class AnimatedMessage extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final VoidCallback? onDismiss;

  const AnimatedMessage({
    super.key,
    required this.message,
    required this.isSuccess,
    this.onDismiss,
  });

  @override
  State<AnimatedMessage> createState() => _AnimatedMessageState();
}

class _AnimatedMessageState extends State<AnimatedMessage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _iconController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Slide-in animation
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start from above
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    // Icon animation (bounce for success, shake for error)
    _iconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.isSuccess ? 600 : 600),
    );

    // Start animations
    _slideController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _iconController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSuccess
                ? AppTheme.greenPrimary.withValues(alpha: 0.1)
                : AppTheme.redPrimary.withValues(alpha: 0.1),
            border: Border.all(
              color: widget.isSuccess ? AppTheme.greenPrimary : AppTheme.redPrimary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: (widget.isSuccess ? AppTheme.greenPrimary : AppTheme.redPrimary)
                    .withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated icon
              widget.isSuccess ? _buildBounceIcon() : _buildShakeIcon(),
              const SizedBox(width: 12),
              // Message text
              Flexible(
                child: Text(
                  widget.message,
                  style: GoogleFonts.tiny5(
                    fontSize: 14,
                    color: widget.isSuccess ? AppTheme.greenPrimary : AppTheme.redPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBounceIcon() {
    // Bounce animation: scale 0.8 -> 1.1 -> 1.0
    return AnimatedBuilder(
      animation: _iconController,
      builder: (context, child) {
        double scale;
        if (_iconController.value < 0.5) {
          // First half: 0.8 -> 1.1
          scale = 0.8 + (_iconController.value * 2) * 0.3;
        } else {
          // Second half: 1.1 -> 1.0
          scale = 1.1 - ((_iconController.value - 0.5) * 2) * 0.1;
        }

        return Transform.scale(
          scale: scale,
          child: Icon(
            Icons.check_circle,
            color: AppTheme.greenPrimary,
            size: 24,
          ),
        );
      },
    );
  }

  Widget _buildShakeIcon() {
    // Shake animation: rotate -5° -> +5° -> -5° -> +5° -> 0°
    return AnimatedBuilder(
      animation: _iconController,
      builder: (context, child) {
        // Create 3 shake cycles
        final cycles = 3;
        final cycleValue = (_iconController.value * cycles) % 1.0;

        // Each cycle: 0 -> 1 -> 0 -> -1 -> 0
        double rotation;
        if (cycleValue < 0.25) {
          rotation = cycleValue * 4; // 0 -> 1
        } else if (cycleValue < 0.5) {
          rotation = 1 - (cycleValue - 0.25) * 4; // 1 -> 0
        } else if (cycleValue < 0.75) {
          rotation = -(cycleValue - 0.5) * 4; // 0 -> -1
        } else {
          rotation = -1 + (cycleValue - 0.75) * 4; // -1 -> 0
        }

        // Scale down rotation as animation progresses
        rotation *= (1 - _iconController.value * 0.5);

        return Transform.rotate(
          angle: rotation * 0.1, // Convert to radians (roughly 5 degrees)
          child: Icon(
            Icons.error,
            color: AppTheme.redPrimary,
            size: 24,
          ),
        );
      },
    );
  }
}
