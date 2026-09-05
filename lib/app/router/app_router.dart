import 'package:go_router/go_router.dart';
import 'package:music_player/features/auth/presentation/pages/login_screen.dart';

import 'package:music_player/features/home/presentation/pages/home_screen.dart';
import 'package:music_player/features/auth/presentation/pages/splash_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: SplashScreen.name, // This tells the app which screen to show first
  routes: [
    GoRoute(
      path: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
