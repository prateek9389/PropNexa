import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class AdminPropertiesScreen extends StatefulWidget {
  const AdminPropertiesScreen({super.key});

  @override
  State<AdminPropertiesScreen> createState() => _AdminPropertiesScreenState();
}

class _AdminPropertiesScreenState extends State<AdminPropertiesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Management'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending Review'),
            Tab(text: 'Approved'),
            Tab(text: 'Published'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPropertiesTable(null),
          _buildPropertiesTable('Pending Review'),
          _buildPropertiesTable('Approved'),
          _buildPropertiesTable('Published'),
          _buildPropertiesTable('Rejected'),
        ],
      ),
    );
  }

  Widget _buildPropertiesTable(String? statusFilter) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.deepNavy),
              columns: const [
                DataColumn(label: Text('Property ID')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: [
                _buildRow('PN-1001', 'Luxury 3 BHK in Noida', 'Apartment', '₹1.2 Cr', 'Published', AppColors.statusPublished),
                _buildRow('PN-1002', 'Office Space in Delhi', 'Commercial', '₹45,000/mo', 'Pending Review', AppColors.statusPending),
                _buildRow('PN-1003', 'Independent Villa', 'Villa', '₹2.5 Cr', 'Approved', AppColors.statusApproved),
              ].where((row) {
                if (statusFilter == null) return true;
                final statusCell = (row.cells[4].child as Container).child as Text;
                return statusCell.data == statusFilter;
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  DataRow _buildRow(String id, String title, String type, String price, String status, Color statusColor) {
    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(title)),
        DataCell(Text(type)),
        DataCell(Text(price)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
          )
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.visibility, color: AppColors.primaryBlue), onPressed: () => _showReviewDialog(id)),
            ],
          )
        ),
      ]
    );
  }

  void _showReviewDialog(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Review Property $id'),
        content: const SizedBox(
          width: 500,
          child: Text('In a full implementation, this modal would contain a split layout showing property media on the left, and property information + approval controls on the right.'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.statusRejected),
            onPressed: () => Navigator.pop(context),
            child: const Text('Reject'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.statusPending),
            onPressed: () => Navigator.pop(context),
            child: const Text('Request Changes'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.statusApproved),
            onPressed: () => Navigator.pop(context),
            child: const Text('Approve'),
          ),
        ],
      )
    );
  }
}

