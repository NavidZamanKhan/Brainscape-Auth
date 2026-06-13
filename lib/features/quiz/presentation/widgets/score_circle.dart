import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Animated circular score indicator using [CustomPainter].
class ScoreCircle extends StatefulWidget {
  final int score;
  final int total;
  const ScoreCircle({super.key, required this.score, required this.total});

  @override
  State<ScoreCircle> createState() => _ScoreCircleState();
}

class _ScoreCircleState extends State<ScoreCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fraction =
        widget.total == 0 ? 0.0 : widget.score / widget.total;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final animValue = Curves.easeOutCubic.transform(_ctrl.value);
        final currentFraction = fraction * animValue;
        final displayScore = (widget.score * animValue).round();
        return SizedBox(
          width: AppDimensions.scoreCircleSize,
          height: AppDimensions.scoreCircleSize,
          child: CustomPaint(
            painter: _ScoreArcPainter(
              progress: currentFraction,
              bgColor: Colors.white.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$displayScore',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: AppColors.whiteText,
                      height: 1,
                    ),
                  ),
                  Text(
                    'of ${widget.total}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.mutedText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Custom painter for the score arc ──

class _ScoreArcPainter extends CustomPainter {
  final double progress;
  final Color bgColor;
  _ScoreArcPainter({required this.progress, required this.bgColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = AppDimensions.scoreArcStrokeWidth;
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    // Background arc
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground gradient arc
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: const [
          AppColors.deepPurple,
          AppColors.electricBlue,
          AppColors.cyan,
        ],
        transform: const GradientRotation(-math.pi / 2),
      );
      final fgPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        fgPaint,
      );

      // Glow dot at the tip
      final tipAngle = startAngle + sweepAngle;
      final tipX = center.dx + radius * math.cos(tipAngle);
      final tipY = center.dy + radius * math.sin(tipAngle);
      final glowPaint = Paint()
        ..color = AppColors.cyan.withValues(alpha: 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(tipX, tipY), 6, glowPaint);
      canvas.drawCircle(
        Offset(tipX, tipY),
        4,
        Paint()..color = AppColors.whiteText,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScoreArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
