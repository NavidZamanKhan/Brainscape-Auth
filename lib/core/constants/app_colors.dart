import 'package:flutter/material.dart';

/// Central color palette for the Brainscape app.
///
/// All colors are defined as static constants to ensure consistency
/// across the entire application and enable easy theme modifications.
class AppColors {
  AppColors._();

  // ── Primary background ──
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color backgroundAccent = Color(0xFF1E1B4B);

  // ── Brand accent colors ──
  static const Color deepPurple = Color(0xFF7C3AED);
  static const Color electricBlue = Color(0xFF38BDF8);
  static const Color cyan = Color(0xFF22D3EE);

  // ── Semantic colors ──
  static const Color greenSuccess = Color(0xFF22C55E);
  static const Color redError = Color(0xFFEF4444);

  // ── Text colors ──
  static const Color whiteText = Color(0xFFF8FAFC);
  static const Color mutedText = Color(0xFFCBD5E1);

  // ── Card / glass ──
  static const Color cardBg = Color(0x1AFFFFFF);
  static const Color cardBorder = Color(0x33FFFFFF);

  // ── Confetti extras ──
  static const Color confettiGold = Color(0xFFFBBF24);
  static const Color confettiPink = Color(0xFFF472B6);
}
