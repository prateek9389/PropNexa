import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/property_card.dart';
import '../../../models/property.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _searchTypeIndex = 0; // 0: Buy, 1: Rent
  String _activeCategory = 'All';
  bool _isListView = true;

  final List<Property> mockProperties = [
    Property(
      id: 'prop1',
      title: '3 BHK Luxury Apartment',
      description: '',
      price: 7500000,
      location: 'Sector 62, Noida',
      type: PropertyType.apartment,
      status: PropertyStatus.published,
      ownerId: 'owner1',
      purpose: PropertyPurpose.buy,
      furnishing: 'Semi-Furnished',
      amenities: ['Parking'],
      images: ['https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800'],
      postedDate: DateTime.now(),
      bhk: 3,
      bathrooms: 2,
      area: 1450,
    ),
    Property(
      id: 'prop2',
      title: '2 BHK Apartment',
      description: '',
      price: 4200000,
      location: 'Sector 75, Noida',
      type: PropertyType.apartment,
      status: PropertyStatus.published,
      ownerId: 'owner2',
      purpose: PropertyPurpose.buy,
      furnishing: 'Unfurnished',
      amenities: [],
      images: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800'],
      postedDate: DateTime.now(),
      bhk: 2,
      bathrooms: 2,
      area: 1100,
    ),
    Property(
      id: 'prop3',
      title: '4 BHK Villa',
      description: '',
      price: 12000000,
      location: 'Greater Noida',
      type: PropertyType.villa,
      status: PropertyStatus.published,
      ownerId: 'owner3',
      purpose: PropertyPurpose.buy,
      furnishing: 'Furnished',
      amenities: ['Pool', 'Garden'],
      images: ['https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800'],
      postedDate: DateTime.now(),
      bhk: 4,
      bathrooms: 4,
      area: 2200,
    ),
    Property(
      id: 'prop4',
      title: '2 BHK Flat',
      description: '',
      price: 25000,
      location: 'Sector 137, Noida',
      type: PropertyType.apartment,
      status: PropertyStatus.published,
      ownerId: 'owner4',
      purpose: PropertyPurpose.rent,
      furnishing: 'Semi-Furnished',
      amenities: [],
      images: ['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800'],
      postedDate: DateTime.now(),
      bhk: 2,
      bathrooms: 2,
      area: 1000,
    ),
    Property(
      id: 'prop5',
      title: 'Office Space',
      description: '',
      price: 60000,
      location: 'Sector 62, Noida',
      type: PropertyType.commercial,
      status: PropertyStatus.published,
      ownerId: 'owner5',
      purpose: PropertyPurpose.rent,
      furnishing: 'Furnished',
      amenities: ['AC'],
      images: ['https://images.unsplash.com/photo-1497366216548-37526070297c?w=800'],
      postedDate: DateTime.now(),
      bhk: 0,
      bathrooms: 2,
      area: 1200,
    ),
  ];

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.grid_view, 'label': 'All', 'color': Colors.blue},
    {'icon': Icons.apartment, 'label': 'Apartment', 'color': Colors.blue},
    {'icon': Icons.house, 'label': 'House', 'color': Colors.orange},
    {'icon': Icons.villa, 'label': 'Villa', 'color': Colors.orangeAccent},
    {'icon': Icons.landscape, 'label': 'Plot', 'color': Colors.green},
    {'icon': Icons.business, 'label': 'Commercial', 'color': Colors.purple},
    {'icon': Icons.work, 'label': 'Office', 'color': Colors.blueAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopBar(),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Search Bar
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                      
                      // Segmented Control
                      _buildSegmentedControl(),
                      const SizedBox(height: 24),
                      
                      // Categories Row
                      _buildCategories(),
                      const SizedBox(height: 24),
                      
                      // Quick Filters Row
                      _buildQuickFilters(),
                      const SizedBox(height: 24),
                      
                      // Header
                      _buildListHeader(),
                      const SizedBox(height: 16),
                      
                      // Properties List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mockProperties.length,
                        itemBuilder: (context, index) {
                          return PropertyCard(
                            property: mockProperties[index],
                            isHorizontal: true,
                          );
                        },
                      ),
                      const SizedBox(height: 100), // Bottom padding for FAB
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          Row(
            children: [
              // Location Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.location_on_outlined, color: AppColors.primaryBlue, size: 16),
                    SizedBox(width: 4),
                    Text('Noida', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, color: AppColors.primaryBlue, size: 16),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Bell Icon
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search properties, locations, or landmarks...',
          hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: const Icon(Icons.mic_none, color: AppColors.textSecondary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
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
          final isSelected = _activeCategory == category['label'];
          return GestureDetector(
            onTap: () => setState(() => _activeCategory = category['label'] as String),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.borderLight),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2))
                      ],
                    ),
                    child: Icon(category['icon'] as IconData, color: isSelected ? Colors.white : category['color'] as Color, size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.push(AppRoutes.filter),
            child: _buildFilterPill(Icons.filter_alt_outlined, 'Filters', hasBorder: true),
          ),
          const SizedBox(width: 8),
          _buildFilterPill(Icons.swap_vert, 'Sort'),
          const SizedBox(width: 8),
          _buildFilterPill(Icons.currency_rupee, 'Price'),
          const SizedBox(width: 8),
          _buildFilterPill(Icons.hotel_outlined, 'BHK'),
          const SizedBox(width: 8),
          _buildFilterPill(Icons.more_horiz, 'More'),
        ],
      ),
    );
  }

  Widget _buildFilterPill(IconData icon, String label, {bool hasBorder = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '125 Properties Found',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // List View Toggle
              GestureDetector(
                onTap: () => setState(() => _isListView = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isListView ? AppColors.primaryDark : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.format_list_bulleted, size: 16, color: _isListView ? Colors.white : AppColors.textPrimary),
                      const SizedBox(width: 4),
                      Text('List', style: TextStyle(color: _isListView ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              // Map View Toggle
              GestureDetector(
                onTap: () {
                  setState(() => _isListView = false);
                  context.push(AppRoutes.map);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: !_isListView ? AppColors.primaryDark : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.map_outlined, size: 16, color: !_isListView ? Colors.white : AppColors.textPrimary),
                      const SizedBox(width: 4),
                      Text('Map', style: TextStyle(color: !_isListView ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
