import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A softly pulsating, semi-transparent decorative circle.
///
/// Must be placed inside a [Stack] because it uses [Positioned].
class AnimatedBlob extends StatefulWidget {
  final double size;
  final Color color;
  final Offset offset;
  final Duration duration;

  const AnimatedBlob({
    super.key,
    required this.size,
    required this.color,
    required this.offset,
    this.duration = const Duration(seconds: 6),
  });

  @override
  State<AnimatedBlob> createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<AnimatedBlob>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final t = _ctrl.value;
        return Positioned(
          left: widget.offset.dx + math.sin(t * math.pi) * 18,
          top: widget.offset.dy + math.cos(t * math.pi) * 18,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  widget.color.withValues(alpha: 0.25),
                  widget.color.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
