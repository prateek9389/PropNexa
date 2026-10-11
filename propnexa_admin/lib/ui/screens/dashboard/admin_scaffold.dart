import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/admin_routes.dart';
import '../../../core/theme/app_theme.dart';

class AdminScaffold extends StatelessWidget {
  final Widget child;

  const AdminScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      appBar: isDesktop ? null : AppBar(
        title: const Text('PropNexa Admin'),
      ),
      drawer: isDesktop ? null : _buildSidebar(context),
      body: Row(
        children: [
          if (isDesktop) SizedBox(width: 280, child: _buildSidebar(context)),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.security, color: AppColors.primaryBlue, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Admin Panel',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepNavy,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildNavItem(context, 'Dashboard', Icons.dashboard, AdminRoutes.dashboard, currentRoute),
                _buildNavItem(context, 'Properties', Icons.business, AdminRoutes.properties, currentRoute),
                _buildNavItem(context, 'Requirements', Icons.find_in_page, AdminRoutes.requirements, currentRoute),
                _buildNavItem(context, 'Users', Icons.people, AdminRoutes.users, currentRoute),
                _buildNavItem(context, 'Messages', Icons.message, AdminRoutes.messages, currentRoute),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            leading: const CircleAvatar(
              backgroundColor: AppColors.primaryBlue,
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
            title: const Text('Admin User', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Logout', style: TextStyle(color: AppColors.statusRejected)),
            onTap: () => context.go(AdminRoutes.login),
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon, String route, String currentRoute) {
    final isSelected = currentRoute == route;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: () {
          if (!isSelected) {
            context.go(route);
          }
          if (MediaQuery.of(context).size.width < 1024 && Navigator.canPop(context)) {
            Navigator.pop(context); // close drawer on mobile
          }
        },
      ),
    );
  }
}

