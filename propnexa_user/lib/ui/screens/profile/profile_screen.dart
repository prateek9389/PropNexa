import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Top Light Blue Gradient Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade100.withOpacity(0.5),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Profile Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            // Avatar with Camera Badge
                            Stack(
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=200'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                                      ],
                                    ),
                                    child: const Icon(Icons.camera_alt, color: AppColors.primaryBlue, size: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            // Name, Email, Edit Button
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Prateek Kumar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Text(
                                      'prateek@gmail.com',
                                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
                                  ),
                                  child: const Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Settings Gear
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(Icons.settings_outlined, color: AppColors.textPrimary, size: 24),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Stats Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('12', 'Listings'),
                        _buildStat('4', 'Requirements'),
                        _buildStat('28', 'Saved'),
                        _buildStat('156', 'Views'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Menu Sections
                  _buildMenuSection(
                    title: 'My Activity',
                    items: [
                      _MenuItem(icon: Icons.home_outlined, title: 'My Listings'),
                      _MenuItem(icon: Icons.favorite_border, title: 'My Requirements'),
                      _MenuItem(icon: Icons.favorite_border, title: 'Saved Properties'),
                      _MenuItem(icon: Icons.manage_search_outlined, title: 'Recently Viewed'),
                    ],
                  ),
                  
                  _buildMenuSection(
                    title: 'Communication',
                    items: [
                      _MenuItem(icon: Icons.chat_bubble_outline, title: 'Chat with Admin', badge: 3),
                      _MenuItem(icon: Icons.notifications_none, title: 'Notifications'),
                      _MenuItem(icon: Icons.help_outline, title: 'Help & Support'),
                    ],
                  ),
                  
                  _buildMenuSection(
                    title: 'Settings',
                    items: [
                      _MenuItem(icon: Icons.settings_outlined, title: 'Settings'),
                    ],
                  ),
                  
                  const SizedBox(height: 80), // Padding for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection({required String title, required List<_MenuItem> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              children: List.generate(items.length, (index) {
                final item = items[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(item.icon, color: AppColors.primaryBlue, size: 24),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.badge != null)
                            Container(
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                item.badge.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
                        ],
                      ),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    ),
                    if (index < items.length - 1)
                      const Divider(height: 1, thickness: 1, color: AppColors.borderLight, indent: 56),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final int? badge;

  _MenuItem({required this.icon, required this.title, this.badge});
}
