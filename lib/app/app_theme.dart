import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// Premium dark Material 3 theme for the Brainscape app.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        colorSchemeSeed: AppColors.deepPurple,
        fontFamily: 'Roboto',
      );
}
