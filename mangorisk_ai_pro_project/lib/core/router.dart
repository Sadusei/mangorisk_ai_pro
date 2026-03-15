import 'package:go_router/go_router.dart';

import '../screens/auth/auth_screen.dart';
import '../screens/shell/shell_screen.dart';

final router = GoRouter(
  initialLocation: "/auth",
  routes: [
    GoRoute(
      path: "/auth",
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: "/app",
      builder: (context, state) => const ShellScreen(),
    ),
  ],
);