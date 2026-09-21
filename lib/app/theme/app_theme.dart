import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_player/app/theme/app_colors.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.system,
  );

  static const String _themePrefKey = 'theme_mode';

  static Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themePrefKey);
    if (isDark != null) {
      themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  static Future<void> toggleTheme(ThemeMode mode) async {
    themeNotifier.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefKey, mode == ThemeMode.dark);
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        surface: AppColors.lightBackground,
        onSurface: AppColors.lightText,
        surfaceContainer: Color(0xFFF5F5F5),
        surfaceContainerHighest: Color(0xFFE0E0E0),
        primaryContainer: Color(0xFFFFD1DC),
        onPrimaryContainer: Colors.black,
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
        surfaceContainer: Color(0xFF1E1E1E),
        surfaceContainerHighest: Color(0xFF333333),
        primaryContainer: Color(0xFF5A2A3A),
        onPrimaryContainer: Colors.white,
      ),
      textTheme: Typography.material2021(platform: TargetPlatform.android).white
          .apply(
            bodyColor: AppColors.darkText,
            displayColor: AppColors.darkText,
          ),
    );
  }
}
