import 'package:flutter/material.dart';
import 'package:music_player/app/theme/app_colors.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.system,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        surface: AppColors.lightBackground,
        onSurface: AppColors.lightText,
      ),
      textTheme: Typography.material2021(platform: TargetPlatform.android).black
          .apply(
            bodyColor: AppColors.lightText,
            displayColor: AppColors.lightText,
          ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.darkBackground,
        onSurface: AppColors.darkText,
      ),
      textTheme: Typography.material2021(platform: TargetPlatform.android).white
          .apply(
            bodyColor: AppColors.darkText,
            displayColor: AppColors.darkText,
          ),
    );
  }
}
