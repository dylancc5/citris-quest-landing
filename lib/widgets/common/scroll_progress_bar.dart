import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../ui/painters/segmented_progress_painter.dart';

/// Pixel-style segmented scroll progress bar
/// Shows at top of viewport, fills left-to-right as user scrolls
class ScrollProgressBar extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollProgressBar({
    super.key,
    required this.scrollController,
  });

  @override
  State<ScrollProgressBar> createState() => _ScrollProgressBarState();
}

class _ScrollProgressBarState extends State<ScrollProgressBar> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;

    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;

    if (maxScroll > 0) {
      final newProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);

      // Only update if progress changed significantly (reduces repaints)
      if ((newProgress - _progress).abs() > 0.001) {
        setState(() {
          _progress = newProgress;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate segment count based on screen width
    // Target: ~50-60px per segment
    final segmentCount = (screenWidth / 55).round().clamp(20, 30);

    // Calculate top position to stay below sticky nav bar
    // Nav bar height: 64px (mobile) or 80px (desktop)
    final isMobile = screenWidth < 768;
    final navBarHeight = isMobile ? 64.0 : 80.0;

    return Positioned(
      top: navBarHeight,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 4,
        child: CustomPaint(
          painter: SegmentedProgressPainter(
            progress: _progress,
            filledColor: AppTheme.cyanAccent,
            emptyColor: Colors.white.withValues(alpha: 0.1),
            segmentCount: segmentCount,
          ),
        ),
      ),
    );
  }
}
