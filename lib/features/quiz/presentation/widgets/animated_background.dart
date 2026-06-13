import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Full-screen gradient background used on every screen.
class AnimatedBackground extends StatelessWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundDark,
            AppColors.backgroundAccent,
            AppColors.backgroundDark,
          ],
        ),
      ),
      child: child,
    );
  }
}
