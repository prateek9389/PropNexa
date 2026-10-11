import 'package:flutter/material.dart';
import 'core/routes/admin_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const PropNexaAdminApp());
}

class PropNexaAdminApp extends StatelessWidget {
  const PropNexaAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PropNexa Admin Panel',
      theme: AppTheme.lightTheme,
      routerConfig: AdminRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

