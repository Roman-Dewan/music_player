import 'package:go_router/go_router.dart';
import 'package:learn_go_router/features/auth/presentation/pages/login_screen.dart';

import 'package:learn_go_router/features/home/presentation/pages/home_screen.dart';
import 'package:learn_go_router/features/auth/presentation/pages/splash_screen.dart';

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
