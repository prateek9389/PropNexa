import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/property.dart';
import '../../../services/property_service.dart';
import '../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailsScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final propertyService = Provider.of<IPropertyService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Property?>(
        future: propertyService.getPropertyById(widget.propertyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(child: Text('Property not found'));
          }

          final property = snapshot.data!;
          // Using en_IN locale for proper Indian Rupee formatting
          final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0, locale: 'en_IN');

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _buildSliverAppBar(property),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildTitleAndVerified(property),
                          const SizedBox(height: 8),
                          _buildPrice(formatCurrency, property),
                          const SizedBox(height: 16),
                          _buildLocation(property),
                          const SizedBox(height: 24),
                          _buildFeaturesGrid(property),
                          const SizedBox(height: 24),
                          _buildTabs(),
                          const SizedBox(height: 24),
                          _buildDescription(property),
                          const SizedBox(height: 24),
                          _buildAmenities(),
                          const SizedBox(height: 24),
                          _buildPropertyOwner(),
                          const SizedBox(height: 120), // Bottom padding for action bar
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildBottomActionBar(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(Property property) {
    return SliverAppBar(
      expandedHeight: 340.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildIconBtn(Icons.arrow_back, () => context.pop(), isDark: true),
      ),
      actions: [
        _buildIconBtn(Icons.favorite, () {}, isDark: false, iconColor: Colors.red),
        const SizedBox(width: 8),
        _buildIconBtn(Icons.share_outlined, () {}, isDark: true),
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              property.images.isNotEmpty ? property.images.first : 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
              fit: BoxFit.cover,
            ),
            // Bottom gradient to make thumbnails pop
            Positioned(
              bottom: 0, left: 0, right: 0,
              height: 120,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent],
                  )
                ),
              ),
            ),
            // Photo count pill
            Positioned(
              bottom: 80,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.photo_library_outlined, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text('1/10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
            ),
            // Floating thumbnails
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    bool isLast = index == 4;
                    bool isActive = index == 0;
                    return Container(
                      width: (MediaQuery.of(context).size.width - 32 - 32) / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: isActive ? Border.all(color: Colors.white, width: 2.5) : null,
                        image: DecorationImage(
                          image: NetworkImage(property.images.isNotEmpty ? property.images.first : 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: isLast ? Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 28),
                      ) : null,
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, VoidCallback onTap, {bool isDark = false, Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? (isDark ? Colors.white : AppColors.textPrimary), size: 20),
      ),
    );
  }

  Widget _buildTitleAndVerified(Property property) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            property.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.statusApproved.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, size: 14, color: AppColors.statusApproved),
              SizedBox(width: 4),
              Text(
                'PropNexa Verified',
                style: TextStyle(color: AppColors.statusApproved, fontSize: 11, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(NumberFormat formatCurrency, Property property) {
    return Row(
      children: [
        Text(
          formatCurrency.format(property.price),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.primaryBlue),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Negotiable',
            style: TextStyle(color: AppColors.primaryBlue, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(Property property) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: AppColors.textSecondary, size: 18),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            property.location,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
        ),
        const Text(
          'View on Map >',
          style: TextStyle(color: AppColors.primaryBlue, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid(Property property) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFeatureCol(Icons.bed_outlined, '${property.bhk ?? 3}', 'Bedrooms'),
          _buildDivider(),
          _buildFeatureCol(Icons.bathtub_outlined, '${property.bathrooms ?? 2}', 'Bathrooms'),
          _buildDivider(),
          _buildFeatureCol(Icons.aspect_ratio, '${property.area.toInt()}', 'Sq. Ft.'),
          _buildDivider(),
          _buildFeatureCol(Icons.apartment, '6th', 'Floor'),
          _buildDivider(),
          _buildFeatureCol(Icons.directions_car_outlined, '1', 'Parking'),
        ],
      ),
    );
  }

  Widget _buildFeatureCol(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.textPrimary, size: 22),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.textPrimary, fontSize: 14)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.borderLight,
    );
  }

  Widget _buildTabs() {
    final tabs = ['Overview', 'Amenities', 'Location', 'Price History'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          bool isActive = _selectedTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textPrimary,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDescription(Property property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        const Text(
          'Beautiful 3 BHK apartment in a prime location of Sector 62, Noida with modern amenities and excellent connectivity. This property offers spacious rooms, premium interiors, and a peaceful environment perfect for families.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        Row(
          children: const [
            Text('Read More', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
            Icon(Icons.keyboard_arrow_down, color: AppColors.primaryBlue, size: 16),
          ],
        )
      ],
    );
  }

  Widget _buildAmenities() {
    final List<Map<String, dynamic>> amenitiesList = [
      {'icon': Icons.pool_outlined, 'label': 'Swimming\nPool'},
      {'icon': Icons.fitness_center, 'label': 'Gym'},
      {'icon': Icons.house_outlined, 'label': 'Club House'},
      {'icon': Icons.rocket_launch_outlined, 'label': 'Kids Play\nArea'},
      {'icon': Icons.verified_user_outlined, 'label': 'Security\n24x7'},
      {'icon': Icons.battery_charging_full_outlined, 'label': 'Power\nBackup'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Amenities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            Text('See All', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: amenitiesList.map((amenity) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(amenity['icon'] as IconData, color: AppColors.primaryBlue, size: 28),
                    const SizedBox(height: 12),
                    Text(
                      amenity['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, color: AppColors.textPrimary, fontWeight: FontWeight.w600, height: 1.2),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyOwner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Property Owner',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=200'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Rohit Sharma', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    SizedBox(height: 2),
                    Text('Individual Owner', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text('Member since Jan 2024', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  minimumSize: Size.zero,
                ),
                icon: const Icon(Icons.call, color: AppColors.primaryBlue, size: 16),
                label: const Text('View Contact', style: TextStyle(color: AppColors.primaryBlue, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.borderLight)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size.zero,
                  ),
                  icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primaryBlue, size: 18),
                  label: const Text('Chat', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size.zero,
                  ),
                  icon: const Icon(Icons.calendar_month_outlined, color: AppColors.primaryBlue, size: 18),
                  label: const Text('Request Visit', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size.zero,
                  ),
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text('Contact Owner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
