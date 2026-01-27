import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/breakpoints.dart';
import '../../services/form_service.dart';
import '../common/primary_button.dart';
import '../common/animated_text_field.dart';
import '../common/animated_message.dart';

/// Contribute section with form
class ContributeSection extends StatefulWidget {
  const ContributeSection({super.key});

  @override
  State<ContributeSection> createState() => _ContributeSectionState();
}

class _ContributeSectionState extends State<ContributeSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _contributionType = 'Artwork Submission';
  bool _isSubmitting = false;
  String? _statusMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _statusMessage = null;
    });

    final success = await FormService().submitContribution(
      name: _nameController.text,
      email: _emailController.text,
      contributionType: _contributionType,
      message: _messageController.text,
    );

    setState(() {
      _isSubmitting = false;
      if (success) {
        _statusMessage = 'Thank you! We\'ll be in touch soon.';
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        _contributionType = 'Artwork Submission';
      } else {
        _statusMessage = 'Submission failed. Please try again or email us directly.';
      }
    });

    // Auto-dismiss success message after 3 seconds
    if (success) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _statusMessage = null);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: EdgeInsets.symmetric(
        horizontal: Breakpoints.horizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'CONTRIBUTE',
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
          const SizedBox(height: 16),
          Text(
            'Help us improve CITRIS Quest! Submit artwork, suggest features, or report bugs.',
            style: GoogleFonts.tiny5(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AnimatedTextField(
                  controller: _nameController,
                  label: 'Your Name',
                  minLength: 2,
                ),
                const SizedBox(height: 20),
                AnimatedTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  isEmail: true,
                  minLength: 5,
                ),
                const SizedBox(height: 20),
                _buildDropdown(),
                const SizedBox(height: 20),
                AnimatedTextField(
                  controller: _messageController,
                  label: 'Tell us more',
                  minLength: 10,
                  maxLines: 5,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: _isSubmitting ? 'Submitting...' : 'Submit Contribution',
                  onPressed: _isSubmitting ? null : _submitForm,
                  width: double.infinity,
                  height: 60,
                ),
                if (_statusMessage != null) ...[
                  const SizedBox(height: 16),
                  AnimatedMessage(
                    message: _statusMessage!,
                    isSuccess: _statusMessage!.startsWith('Thank'),
                    onDismiss: () => setState(() => _statusMessage = null),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _contributionType,
      style: GoogleFonts.tiny5(fontSize: 16, color: Colors.white),
      dropdownColor: AppTheme.backgroundSecondary,
      decoration: InputDecoration(
        labelText: 'Contribution Type',
        labelStyle: GoogleFonts.tiny5(color: AppTheme.cyanAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.cyanAccent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.cyanAccent, width: 2),
        ),
      ),
      items: [
        'Artwork Submission',
        'CV Model Improvements',
        'General Ideas',
        'Bug Reports',
      ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
      onChanged: (value) {
        setState(() => _contributionType = value!);
      },
    );
  }
}
