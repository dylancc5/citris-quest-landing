import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

/// Custom text field with animated focus glow effect
class AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isEmail;
  final int minLength;
  final int maxLines;

  const AnimatedTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isEmail = false,
    this.minLength = 2,
    this.maxLines = 1,
  });

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppTheme.cyanAccent.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        style: GoogleFonts.tiny5(fontSize: 16, color: Colors.white),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: GoogleFonts.tiny5(
            color: _isFocused ? AppTheme.cyanAccent : AppTheme.cyanAccent.withValues(alpha: 0.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.cyanAccent.withValues(alpha: 0.7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.cyanAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.redPrimary, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.redPrimary, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          filled: true,
          fillColor: AppTheme.backgroundPrimary,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < widget.minLength) {
            return 'Must be at least ${widget.minLength} characters';
          }
          if (widget.isEmail && !value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}
