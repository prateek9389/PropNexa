import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/screens/auth/admin_login_screen.dart';
import '../../ui/screens/dashboard/admin_scaffold.dart';
import '../../ui/screens/dashboard/admin_dashboard_screen.dart';
import '../../ui/screens/properties/admin_properties_screen.dart';

class AdminRoutes {
  static const login = '/login';
  static const dashboard = '/';
  static const properties = '/properties';
  static const requirements = '/requirements';
  static const users = '/users';
  static const messages = '/messages';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AdminScaffold(child: child),
        routes: [
          GoRoute(
            path: dashboard,
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: properties,
            builder: (context, state) => const AdminPropertiesScreen(),
          ),
          GoRoute(
            path: requirements,
            builder: (context, state) => const Center(child: Text('Requirements WIP')),
          ),
          GoRoute(
            path: users,
            builder: (context, state) => const Center(child: Text('Users WIP')),
          ),
          GoRoute(
            path: messages,
            builder: (context, state) => const Center(child: Text('Messages WIP')),
          ),
        ],
      ),
    ],
  );
}

