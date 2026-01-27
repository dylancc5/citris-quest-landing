import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../painters/corner_brackets_painter.dart';

/// Primary CTA button with retro pixel-art styling and hover effects
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 60.0,
    this.borderColor,
    this.textColor,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  double get _glowBlur {
    if (_isPressed) return 50.0; // Increased from 35 for stronger press effect
    if (_isHovered) return 25.0;
    return 15.0;
  }

  double get _scale {
    if (_isPressed) return 0.95; // Scale down on press
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.borderColor ?? AppTheme.cyanAccent;
    final textColor = widget.textColor ?? AppTheme.cyanAccent;
    final isEnabled = widget.onPressed != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: isEnabled ? widget.onPressed : null,
        child: AnimatedScale(
          scale: _scale,
          duration: Duration(milliseconds: _isPressed ? 100 : 200),
          curve: _isPressed ? Curves.easeOut : Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          width: widget.width ?? 200,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(
              color: isEnabled ? borderColor : AppTheme.textDisabled,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: borderColor.withValues(alpha: 0.4),
                      blurRadius: _glowBlur,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              // Corner brackets
              if (isEnabled)
                CustomPaint(
                  painter: CornerBracketsPainter(
                    color: borderColor,
                    pixelSize: 6,
                  ),
                  size: Size(widget.width ?? 200, widget.height!),
                ),
              // Button text
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.text.toUpperCase(),
                    style: GoogleFonts.tiny5(
                      fontSize: 20, // Fixed larger size instead of responsive
                      color: isEnabled ? textColor : AppTheme.textDisabled,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      height: 1.0, // Set line height to 1.0 for proper vertical centering
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
