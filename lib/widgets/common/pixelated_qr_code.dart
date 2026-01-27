import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

/// Pixelated QR code with neon cyan styling
/// Displays a scannable QR code with retro aesthetic matching the app theme
class PixelatedQrCode extends StatelessWidget {
  final String data;
  final double size;
  final String? label;

  const PixelatedQrCode({
    super.key,
    required this.data,
    this.size = 240,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Use smaller size on mobile
    final qrSize = MediaQuery.of(context).size.width < 600 ? 200.0 : size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // QR Code with glowing border
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0E27), // Dark navy background
            border: Border.all(
              color: AppTheme.cyanAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.cyanAccent.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: qrSize,
            backgroundColor: Colors.transparent,
            // Use cyan for QR code dots
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppTheme.cyanAccent,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppTheme.cyanAccent,
            ),
            // High error correction allows for larger "pixels"
            errorCorrectionLevel: QrErrorCorrectLevel.H,
            // Padding around QR code
            padding: const EdgeInsets.all(8),
          ),
        ),

        // Label below QR code
        if (label != null) ...[
          const SizedBox(height: 16),
          Text(
            label!,
            style: GoogleFonts.tiny5(
              fontSize: 14,
              color: AppTheme.cyanAccent,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
