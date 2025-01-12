import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,
      fontFamily: "Montserrat",
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,
      fontFamily: "Montserrat",
    );
  }
}
