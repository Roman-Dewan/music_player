import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/app/router/app_router.dart';
import 'package:music_player/core/di/injection.dart' as di;
import 'package:music_player/app/theme/app_theme.dart';
import 'package:music_player/app/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: AppTheme.themeNotifier,
          builder: (_, ThemeMode currentMode, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: AppConfig.appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: currentMode,
              routerConfig: appRouter,
            );
          },
        );
      },
    );
  }
}
