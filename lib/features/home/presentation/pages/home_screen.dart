import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/app/theme/app_styles.dart';
import 'package:music_player/app/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Music Player",
                      style: AppStyles.heading(context),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  IconButton(
                    onPressed: () {
                      if (Theme.of(context).brightness == Brightness.dark) {
                        AppTheme.toggleTheme(ThemeMode.light);
                      } else {
                        AppTheme.toggleTheme(ThemeMode.dark);
                      }
                    },
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode
                          : Icons.nightlight_round,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.medical_information_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
