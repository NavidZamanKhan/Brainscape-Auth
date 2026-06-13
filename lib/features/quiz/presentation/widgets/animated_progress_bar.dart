import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Animated gradient progress bar using [TweenAnimationBuilder].
class AnimatedProgressBar extends StatelessWidget {
  /// Progress value between 0.0 and 1.0.
  final double progress;

  const AnimatedProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${(value * 100).round()}%',
              style: const TextStyle(
                color: AppColors.mutedText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: AppDimensions.progressBarHeight,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusSm),
                color: Colors.white.withValues(alpha: 0.08),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: value.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSm),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.deepPurple,
                          AppColors.electricBlue,
                          AppColors.cyan,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              AppColors.electricBlue.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
