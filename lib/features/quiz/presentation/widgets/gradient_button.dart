import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Premium gradient button with press animation and disabled state.
class GradientButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;

  const GradientButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.enabled = true,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.enabled && widget.onTap != null;
    return GestureDetector(
      onTapDown: isActive ? (_) => setState(() => _pressed = true) : null,
      onTapUp: isActive
          ? (_) {
              setState(() => _pressed = false);
              widget.onTap?.call();
            }
          : null,
      onTapCancel:
          isActive ? () => setState(() => _pressed = false) : null,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedOpacity(
          opacity: isActive ? 1.0 : 0.4,
          duration: const Duration(milliseconds: 250),
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.buttonVerticalPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              gradient: const LinearGradient(
                colors: [AppColors.deepPurple, AppColors.electricBlue],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.deepPurple.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(widget.icon, color: Colors.white, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
