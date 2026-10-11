import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

class PostSelectionScreen extends StatelessWidget {
  const PostSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Top Sky & Villa Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 320,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFDCEDFD),
                    Color(0xFFEAF4FE),
                    Color(0xFFF8FAFC),
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Modern Villa Hero Image on the right with soft fade mask
                  Positioned(
                    top: 25,
                    right: -25,
                    width: 290,
                    height: 255,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            Color(0x33FFFFFF),
                            Colors.white,
                          ],
                          stops: [0.0, 0.25, 0.6],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/post_hero_banner.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Scrollable Content
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo & Tagline
                      Row(
                        children: [
                          const PropNexaLogoMark(size: 26),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'PropNexa',
                                style: TextStyle(
                                  color: Color(0xFF0F2644),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              Text(
                                'Find. List. Connect.',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Notification Bell with Badge '3'
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              size: 27,
                              color: Color(0xFF0F2644),
                            ),
                          ),
                          Positioned(
                            top: -1,
                            right: -1,
                            child: Container(
                              padding: const EdgeInsets.all(3.5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                              alignment: Alignment.center,
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Hero Titles and Social Proof Pill
                        Padding(
                          padding: const EdgeInsets.only(right: 110.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                    height: 1.2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Post on ',
                                      style: TextStyle(color: Color(0xFF0F172A)),
                                    ),
                                    TextSpan(
                                      text: 'PropNexa',
                                      style: TextStyle(color: Color(0xFF1E60EC)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'List your property, find genuine buyers or tenants, or post your requirements with ease.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                  height: 1.38,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Social Proof Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0F172A).withOpacity(0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 3 Overlapping Avatars
                              SizedBox(
                                width: 52,
                                height: 26,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: _buildAvatarCircle(
                                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80',
                                        const Color(0xFF3B82F6),
                                      ),
                                    ),
                                    Positioned(
                                      left: 14,
                                      child: _buildAvatarCircle(
                                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80',
                                        const Color(0xFF10B981),
                                      ),
                                    ),
                                    Positioned(
                                      left: 28,
                                      child: _buildAvatarCircle(
                                        'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100&auto=format&fit=crop&q=80',
                                        const Color(0xFFF59E0B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '10K+ ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'people have successfully\nposted on PropNexa',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9.5,
                                        color: Color(0xFF475569),
                                        height: 1.25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF64748B),
                                size: 18,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Option 1: Sell Property Card
                        _buildOptionCard(
                          context,
                          tagIcon: Icons.local_offer_outlined,
                          tagText: 'Sell Property',
                          tagColor: const Color(0xFFEF4444),
                          tagBgColor: const Color(0xFFFEE2E2),
                          title: 'Sell Property',
                          description:
                              'List your property for sale and reach genuine buyers. Get the best value for your property.',
                          imagePath: 'assets/images/post_sell_card.jpg',
                          arrowBgColor: const Color(0xFFFFE4E6),
                          arrowColor: const Color(0xFFEF4444),
                          cardBorderColor: const Color(0xFFFFECEC),
                          gradientColors: const [Color(0xFFFFF7F7), Colors.white],
                          shadowColor: const Color(0xFFEF4444),
                          badges: [
                            _buildRupeeBadge('Get Best Value'),
                            _buildIconBadge(Icons.groups_rounded, 'Verified Buyers', const Color(0xFFEF4444)),
                            _buildIconBadge(Icons.rocket_launch_rounded, 'Faster Sale', const Color(0xFFEF4444)),
                          ],
                          onTap: () => context.push(AppRoutes.sellProperty),
                        ),

                        const SizedBox(height: 16),

                        // Option 2: Rent Property Card
                        _buildOptionCard(
                          context,
                          tagIcon: Icons.key_rounded,
                          tagText: 'Rent Property',
                          tagColor: const Color(0xFF2563EB),
                          tagBgColor: const Color(0xFFEFF6FF),
                          title: 'Rent Property',
                          description:
                              'List your property for rent and find verified tenants quickly and securely.',
                          imagePath: 'assets/images/post_rent_card.jpg',
                          arrowBgColor: const Color(0xFFDBEAFE),
                          arrowColor: const Color(0xFF2563EB),
                          cardBorderColor: const Color(0xFFE0E7FF),
                          gradientColors: const [Color(0xFFF3F8FF), Colors.white],
                          shadowColor: const Color(0xFF2563EB),
                          badges: [
                            _buildIconBadge(Icons.groups_rounded, 'Verified Tenants', const Color(0xFF2563EB)),
                            _buildIconBadge(Icons.verified_user_rounded, 'Secure Process', const Color(0xFF2563EB)),
                            _buildIconBadge(Icons.bolt_rounded, 'Quick Renting', const Color(0xFF2563EB)),
                          ],
                          onTap: () => context.push(AppRoutes.sellProperty),
                        ),

                        const SizedBox(height: 16),

                        // Option 3: Post Requirement Card
                        _buildOptionCard(
                          context,
                          tagIcon: Icons.description_outlined,
                          tagText: 'Post Requirement',
                          tagColor: const Color(0xFF059669),
                          tagBgColor: const Color(0xFFDCFCE7),
                          title: 'Post Requirement',
                          description:
                              'Tell us what property you need (buy or rent). Get matched with verified sellers and owners.',
                          imagePath: 'assets/images/post_req_card.jpg',
                          arrowBgColor: const Color(0xFFD1FAE5),
                          arrowColor: const Color(0xFF059669),
                          cardBorderColor: const Color(0xFFDCFCE7),
                          gradientColors: const [Color(0xFFF0FDF4), Colors.white],
                          shadowColor: const Color(0xFF10B981),
                          badges: [
                            _buildIconBadge(Icons.track_changes_rounded, 'Personalized Matches', const Color(0xFF059669)),
                            _buildIconBadge(Icons.notifications_active_rounded, 'Instant Notifications', const Color(0xFF059669)),
                            _buildIconBadge(Icons.groups_rounded, 'Genuine Owners', const Color(0xFF059669)),
                          ],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Post Requirement feature coming up next!'),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // Trust Badges Container
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildTrustItem(
                                  icon: Icons.handshake_outlined,
                                  title: 'Trusted Platform',
                                  subtitle: 'Verified users & listings',
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 38,
                                color: const Color(0xFFE2E8F0),
                              ),
                              Expanded(
                                child: _buildTrustItem(
                                  icon: Icons.verified_user_outlined,
                                  title: 'Safe & Secure',
                                  subtitle: 'Your data is protected',
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 38,
                                color: const Color(0xFFE2E8F0),
                              ),
                              Expanded(
                                child: _buildTrustItem(
                                  icon: Icons.support_agent_outlined,
                                  title: '24/7 Support',
                                  subtitle: "We're always here",
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Extra space at bottom to ensure comfortable scrolling above bottom bar
                        const SizedBox(height: 100),
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

  static Widget _buildAvatarCircle(String imageUrl, Color fallbackColor) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: fallbackColor.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: 24,
          height: 24,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: 14, color: fallbackColor);
          },
        ),
      ),
    );
  }

  static Widget _buildOptionCard(
    BuildContext context, {
    required IconData tagIcon,
    required String tagText,
    required Color tagColor,
    required Color tagBgColor,
    required String title,
    required String description,
    required String imagePath,
    required Color arrowBgColor,
    required Color arrowColor,
    required Color cardBorderColor,
    required List<Color> gradientColors,
    required Color shadowColor,
    required List<Widget> badges,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: cardBorderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3D House / Illustration Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imagePath,
                    width: 95,
                    height: 95,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 95,
                        height: 95,
                        color: tagBgColor,
                        child: Icon(tagIcon, size: 40, color: tagColor),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),

                // Card Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: tagBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(tagIcon, size: 11, color: tagColor),
                            const SizedBox(width: 4),
                            Text(
                              tagText,
                              style: TextStyle(
                                color: tagColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Description
                      Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 11.5,
                          height: 1.35,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Arrow Circle Button
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: arrowBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: arrowColor,
                    size: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Bottom Badges Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: badges,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildRupeeBadge(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Color(0xFFEF4444),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            '₹',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF334155),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static Widget _buildIconBadge(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF334155),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static Widget _buildTrustItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: const Color(0xFF0F172A)),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 9.5,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Custom Brand Logo Mark matching PropNexa's angled house icon
class PropNexaLogoMark extends StatelessWidget {
  final double size;
  final Color color;

  const PropNexaLogoMark({
    super.key,
    this.size = 26,
    this.color = const Color(0xFF0F2644),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 1.15),
      painter: _PropNexaLogoPainter(color: color),
    );
  }
}

class _PropNexaLogoPainter extends CustomPainter {
  final Color color;
  _PropNexaLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Left pillar with slanted roof
    final pathLeft = Path();
    pathLeft.moveTo(0, size.height);
    pathLeft.lineTo(size.width * 0.35, size.height);
    pathLeft.lineTo(size.width * 0.35, size.height * 0.28);
    pathLeft.lineTo(0, size.height * 0.44);
    pathLeft.close();
    canvas.drawPath(pathLeft, paint);

    // Right house shape with gable roof and arched doorway cutout
    final pathRight = Path();
    pathRight.moveTo(size.width * 0.44, size.height * 0.28);
    pathRight.lineTo(size.width * 0.72, 0); // gable roof peak
    pathRight.lineTo(size.width, size.height * 0.34);
    pathRight.lineTo(size.width, size.height);
    pathRight.lineTo(size.width * 0.84, size.height);
    // Doorway cutout
    pathRight.lineTo(size.width * 0.84, size.height * 0.60);
    pathRight.arcToPoint(
      Offset(size.width * 0.60, size.height * 0.60),
      radius: Radius.circular(size.width * 0.12),
      clockwise: false,
    );
    pathRight.lineTo(size.width * 0.60, size.height);
    pathRight.lineTo(size.width * 0.44, size.height);
    pathRight.close();
    canvas.drawPath(pathRight, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
