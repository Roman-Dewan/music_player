import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  // We pass BuildContext so the style automatically adapts to light/dark mode
  // by getting the colors from the current theme.
  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle subheading(BuildContext context) => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
  );
}
