import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/core/di/injection.dart' as di;
import 'package:flutter_app_template/app/theme/app_theme.dart';
import 'package:flutter_app_template/app/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
