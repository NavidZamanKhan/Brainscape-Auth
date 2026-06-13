import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// A single answer option card with stagger entrance,
/// selection scale, and correct/wrong reveal animations.
class OptionTile extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool isRevealed;
  final bool isDisabled;
  final VoidCallback onTap;
  final int staggerIndex;

  const OptionTile({
    super.key,
    required this.text,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.isRevealed,
    required this.isDisabled,
    required this.onTap,
    required this.staggerIndex,
  });

  String get _label => String.fromCharCode(65 + index); // A, B, C, D

  Color get _borderColor {
    if (!isRevealed) {
      return isSelected ? AppColors.electricBlue : AppColors.cardBorder;
    }
    if (isCorrect) return AppColors.greenSuccess;
    if (isSelected && !isCorrect) return AppColors.redError;
    return AppColors.cardBorder;
  }

  Color get _bgColor {
    if (!isRevealed) {
      return isSelected
          ? AppColors.electricBlue.withValues(alpha: 0.12)
          : AppColors.cardBg;
    }
    if (isCorrect) return AppColors.greenSuccess.withValues(alpha: 0.15);
    if (isSelected && !isCorrect) {
      return AppColors.redError.withValues(alpha: 0.15);
    }
    return AppColors.cardBg;
  }

  IconData? get _trailingIcon {
    if (!isRevealed) return null;
    if (isCorrect) return Icons.check_circle_rounded;
    if (isSelected && !isCorrect) return Icons.cancel_rounded;
    return null;
  }

  Color? get _trailingColor {
    if (!isRevealed) return null;
    if (isCorrect) return AppColors.greenSuccess;
    if (isSelected && !isCorrect) return AppColors.redError;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + staggerIndex * 100),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
        child: GestureDetector(
          onTap: isDisabled ? null : onTap,
          child: AnimatedScale(
            scale: isSelected && !isRevealed ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingLg,
                  vertical: AppDimensions.spacingLg),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(
                    color: _borderColor,
                    width: AppDimensions.optionBorderWidth),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: _borderColor.withValues(alpha: 0.25),
                          blurRadius: 12,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: AppDimensions.optionLabelSize,
                    height: AppDimensions.optionLabelSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? _borderColor.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.06),
                      border: Border.all(
                          color: _borderColor,
                          width: AppDimensions.optionBorderWidth),
                    ),
                    child: Center(
                      child: Text(
                        _label,
                        style: TextStyle(
                          color: isSelected
                              ? _borderColor
                              : AppColors.mutedText,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: AppColors.whiteText,
                        fontSize: 15,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        height: 1.35,
                      ),
                    ),
                  ),
                  if (_trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    Icon(_trailingIcon, color: _trailingColor, size: 22),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
