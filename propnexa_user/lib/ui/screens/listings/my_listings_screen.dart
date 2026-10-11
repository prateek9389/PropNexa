import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/property.dart';
import '../../../services/property_service.dart';
import '../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final propertyService = Provider.of<IPropertyService>(context, listen: false);
    final formatCurrency = NumberFormat.compactCurrency(symbol: '₹', decimalDigits: 1);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('My Listings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Approved'),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Property>>(
              future: propertyService.getProperties(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final properties = snapshot.data ?? [];
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildList(properties, null, formatCurrency),
                    _buildList(properties, PropertyStatus.underReview, formatCurrency),
                    _buildList(properties, PropertyStatus.published, formatCurrency),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Property> properties, PropertyStatus? filterStatus, NumberFormat formatCurrency) {
    final filtered = filterStatus == null ? properties : properties.where((p) => p.status == filterStatus).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final property = filtered[index];
        return GestureDetector(
          onTap: () {
            // Navigate to Tracking
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: property.images.isNotEmpty
                        ? DecorationImage(image: NetworkImage(property.images.first), fit: BoxFit.cover)
                        : null,
                    color: Colors.grey.shade200,
                  ),
                  child: property.images.isEmpty ? const Icon(Icons.image, color: Colors.grey) : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(property.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(property.location, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      const SizedBox(height: 8),
                      Text(formatCurrency.format(property.price), style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                _buildStatusBadge(property.status),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(PropertyStatus status) {
    Color color;
    String text;
    switch (status) {
      case PropertyStatus.underReview:
        color = AppColors.statusPending;
        text = 'Pending';
        break;
      case PropertyStatus.published:
        color = AppColors.statusPublished;
        text = 'Published';
        break;
      case PropertyStatus.approved:
        color = AppColors.statusApproved;
        text = 'Approved';
        break;
      case PropertyStatus.rejected:
        color = AppColors.statusRejected;
        text = 'Rejected';
        break;
      default:
        color = AppColors.textSecondary;
        text = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
