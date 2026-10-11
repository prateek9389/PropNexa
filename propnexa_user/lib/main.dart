import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'services/property_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<IPropertyService>(create: (_) => MockPropertyService()),
      ],
      child: const PropNexaUserApp(),
    ),
  );
}

class PropNexaUserApp extends StatelessWidget {
  const PropNexaUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PropNexa',
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

