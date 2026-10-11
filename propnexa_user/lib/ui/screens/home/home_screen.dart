import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/property.dart';
import '../../widgets/featured_property_card.dart';
import '../../widgets/property_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _searchTypeIndex = 0; // 0: Buy, 1: Rent

  final List<Property> mockProperties = [
    Property(
      id: 'prop1',
      title: '3 BHK Luxury Apartment',
      description: 'Beautiful apartment...',
      price: 7500000,
      location: 'Sector 62, Noida',
      type: PropertyType.apartment,
      status: PropertyStatus.published,
      ownerId: 'owner1',
      purpose: PropertyPurpose.buy,
      furnishing: 'Semi-Furnished',
      amenities: ['Parking', 'Gym', 'Pool'],
      images: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800'],
      postedDate: DateTime.now(),
      bhk: 3,
      bathrooms: 2,
      area: 1450,
    ),
    Property(
      id: 'prop2',
      title: '2 BHK Apartment',
      description: 'Cozy apartment...',
      price: 4200000,
      location: 'Sector 75, Noida',
      type: PropertyType.apartment,
      status: PropertyStatus.published,
      ownerId: 'owner2',
      purpose: PropertyPurpose.buy,
      furnishing: 'Unfurnished',
      amenities: ['Parking', 'Security'],
      images: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800'],
      postedDate: DateTime.now(),
      bhk: 2,
      bathrooms: 2,
      area: 1100,
    ),
  ];

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.apartment, 'label': 'Apartment', 'color': Colors.blue},
    {'icon': Icons.house, 'label': 'House', 'color': Colors.orange},
    {'icon': Icons.villa, 'label': 'Villa', 'color': Colors.orangeAccent},
    {'icon': Icons.landscape, 'label': 'Plot', 'color': Colors.green},
    {'icon': Icons.business, 'label': 'Commercial', 'color': Colors.purple},
    {'icon': Icons.work, 'label': 'Office', 'color': Colors.blueAccent},
    {'icon': Icons.grid_view, 'label': 'More', 'color': Colors.grey},
  ];

  final List<Map<String, String>> popularLocations = [
    {'name': 'Noida', 'image': 'assets/images/city_skyline.jpg'},
    {'name': 'Greater Noida', 'image': 'assets/images/city_skyline.jpg'},
    {'name': 'Delhi', 'image': 'assets/images/city_skyline.jpg'},
    {'name': 'Gurgaon', 'image': 'assets/images/city_skyline.jpg'},
    {'name': 'Ghaziabad', 'image': 'assets/images/city_skyline.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Buy / Rent Toggle
                  _buildSegmentedControl(),
                  const SizedBox(height: 24),
                  
                  // Categories
                  _buildCategories(),
                  const SizedBox(height: 32),
                  
                  // Popular Locations
                  _buildSectionHeader('Popular Locations'),
                  const SizedBox(height: 12),
                  _buildPopularLocations(),
                  const SizedBox(height: 32),
                  
                  // Featured Properties
                  _buildSectionHeader('Featured Properties'),
                  const SizedBox(height: 12),
                  _buildFeaturedProperties(),
                  const SizedBox(height: 32),
                  
                  // Recommended for You
                  _buildSectionHeader('Recommended for You'),
                  const SizedBox(height: 12),
                  _buildRecommendedProperties(),
                  const SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        // Background Image Banner
        Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_header_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Gradient overlay for smooth text transition
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.backgroundLight,
                AppColors.backgroundLight.withOpacity(0.8),
                Colors.transparent,
              ],
              stops: const [0.3, 0.6, 1.0],
            ),
          ),
        ),
        
        // Header Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.real_estate_agent, color: AppColors.primaryBlue, size: 32),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'PropNexa',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Find. List. Connect.',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 8),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            const Icon(Icons.notifications_none, size: 28, color: AppColors.textPrimary),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=200'),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 24),
                
                // Welcome Text
                const Text(
                  'Good Morning,',
                  style: TextStyle(fontSize: 18, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Prateek 👋',
                      style: TextStyle(fontSize: 28, color: AppColors.textPrimary, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 24),
                    Transform.rotate(
                      angle: -0.1,
                      child: const Text(
                        'A Better Place\nAwaits You',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryBlue,
                          fontFamily: 'cursive', // Simulating handwriting
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Let's find your perfect property",
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
        
        // Floating Search Bar
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Transform.translate(
            offset: const Offset(0, 24),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by location, property, or landmark...',
                        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: AppColors.borderLight,
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.only(top: 32), // Compensate for floating search bar
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _searchTypeIndex = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _searchTypeIndex == 0 ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('Buy', style: TextStyle(color: _searchTypeIndex == 0 ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _searchTypeIndex = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _searchTypeIndex == 1 ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('Rent', style: TextStyle(color: _searchTypeIndex == 1 ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Icon(category['icon'] as IconData, color: category['color'] as Color, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  category['label'] as String,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        Row(
          children: const [
            Text('See All', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 13)),
            Icon(Icons.chevron_right, color: AppColors.primaryBlue, size: 16),
          ],
        )
      ],
    );
  }

  Widget _buildPopularLocations() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: popularLocations.length,
        itemBuilder: (context, index) {
          final loc = popularLocations[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(loc['image']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(8),
              child: Text(
                loc['name']!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProperties() {
    return SizedBox(
      height: 380, // Large enough for the featured card
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: mockProperties.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.85,
            margin: const EdgeInsets.only(right: 16),
            child: FeaturedPropertyCard(property: mockProperties[index]),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedProperties() {
    return SizedBox(
      height: 240, // Enough for the standard card
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: mockProperties.length,
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 16),
            child: PropertyCard(property: mockProperties[index]),
          );
        },
      ),
    );
  }
}
