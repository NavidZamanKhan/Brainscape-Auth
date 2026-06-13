import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

/// Utility functions for computing quiz result metadata.
class ScoreUtils {
  ScoreUtils._();

  /// Returns a motivational title based on the score percentage.
  static String resultTitle(int score, int total) {
    final pct = total == 0 ? 0.0 : score / total * 100;
    if (pct >= 90) return AppStrings.outstanding;
    if (pct >= 75) return AppStrings.excellentWork;
    if (pct >= 50) return AppStrings.goodEffort;
    return AppStrings.keepPracticing;
  }

  /// Returns an icon appropriate for the score tier.
  static IconData resultIcon(int score, int total) {
    final pct = total == 0 ? 0.0 : score / total * 100;
    if (pct >= 90) return Icons.emoji_events_rounded;
    if (pct >= 75) return Icons.workspace_premium_rounded;
    if (pct >= 50) return Icons.thumb_up_alt_rounded;
    return Icons.trending_up_rounded;
  }

  /// Returns the accuracy percentage as an integer (0–100).
  static int accuracyPercent(int score, int total) {
    if (total == 0) return 0;
    return (score / total * 100).round();
  }
}
