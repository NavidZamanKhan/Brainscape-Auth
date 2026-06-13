import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Lightweight confetti/celebration overlay using [CustomPainter].
///
/// No external packages required. Plays a one-shot 4-second animation.
class CelebrationPainter extends StatefulWidget {
  const CelebrationPainter({super.key});

  @override
  State<CelebrationPainter> createState() => _CelebrationPainterState();
}

class _CelebrationPainterState extends State<CelebrationPainter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_ConfettiParticle> _particles;
  final _rand = math.Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(50, (_) => _ConfettiParticle(_rand));
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();
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
      builder: (context, _) {
        return IgnorePointer(
          child: CustomPaint(
            painter: _ConfettiPainter(
              particles: _particles,
              progress: _ctrl.value,
            ),
            size: MediaQuery.of(context).size,
          ),
        );
      },
    );
  }
}

// ── Particle data ──

class _ConfettiParticle {
  final double x;
  final double speed;
  final double size;
  final double drift;
  final double rotationSpeed;
  final Color color;

  _ConfettiParticle(math.Random r)
      : x = r.nextDouble(),
        speed = 0.4 + r.nextDouble() * 0.6,
        size = 4 + r.nextDouble() * 6,
        drift = (r.nextDouble() - 0.5) * 80,
        rotationSpeed = r.nextDouble() * 4,
        color = [
          AppColors.deepPurple,
          AppColors.electricBlue,
          AppColors.cyan,
          AppColors.greenSuccess,
          AppColors.confettiGold,
          AppColors.confettiPink,
        ][r.nextInt(6)];
}

// ── Painter ──

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;
  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed).clamp(0.0, 1.0);
      final opacity = (1 - t).clamp(0.0, 1.0);
      if (opacity <= 0) continue;

      final px = p.x * size.width + math.sin(t * math.pi * 2) * p.drift;
      final py = -20 + t * (size.height + 40);

      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(t * p.rotationSpeed * math.pi);

      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity * 0.8);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.6,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
