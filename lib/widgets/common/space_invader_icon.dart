import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG-based Space Invader icon widget
class SpaceInvaderIcon extends StatelessWidget {
  final double size;
  final Color color;

  const SpaceInvaderIcon({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // SVG has aspect ratio of 19:24 (width:height)
    final width = size;
    final height = size * (24 / 19);

    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        'assets/icons/space_invader.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        fit: BoxFit.contain,
      ),
    );
  }
}
