import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';

class PostSelectionScreen extends StatelessWidget {
  const PostSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background Top Graphic
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: 60,
                    child: Image.asset(
                      'assets/images/post_house.jpg',
                      width: 250,
                      fit: BoxFit.contain,
                      colorBlendMode: BlendMode.multiply, // Make background blend if needed
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.real_estate_agent, color: AppColors.primaryBlue, size: 28),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'PropNexa',
                            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Find. List. Connect.',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 8),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Header Text
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'What would you\nlike to do?',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryDark,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Choose an option to get started',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Options List
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildOptionCard(
                          context,
                          title: 'Sell Property',
                          subtitle: 'List your property for sale\nand reach genuine buyers.',
                          icon: Icons.home,
                          iconColor: Colors.redAccent,
                          backgroundColor: Colors.red.shade50,
                          onTap: () => context.push(AppRoutes.sellProperty),
                        ),
                        const SizedBox(height: 16),
                        _buildOptionCard(
                          context,
                          title: 'Rent Property',
                          subtitle: 'List your property for rent\nand find the right tenants.',
                          icon: Icons.home_work,
                          iconColor: AppColors.primaryBlue,
                          backgroundColor: Colors.blue.shade50,
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        _buildOptionCard(
                          context,
                          title: 'Post Requirement',
                          subtitle: "Tell us what property\nyou need. We'll help you find it.",
                          icon: Icons.find_in_page,
                          iconColor: Colors.green,
                          backgroundColor: Colors.green.shade50,
                          onTap: () {},
                        ),
                        const SizedBox(height: 24),
                        
                        // Banner Card
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/home_header_bg.jpg'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.9), Colors.transparent],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Transform.rotate(
                                        angle: -0.05,
                                        child: const Text(
                                          'A Better Place\nAwaits You',
                                          style: TextStyle(
                                            fontFamily: 'cursive',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryBlue,
                                            height: 1.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'List. Connect. Grow.',
                                        style: TextStyle(fontSize: 11, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 100), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward, color: iconColor, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
