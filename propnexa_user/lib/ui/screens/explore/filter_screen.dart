import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _purposeIndex = 0; // 0 for Buy, 1 for Rent
  String _selectedPropertyType = 'Apartment';
  double _priceValue = 0.5; // Example 0.5 for a slider value
  int _selectedBHK = 3;
  String _selectedFurnishing = 'Semi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Reset', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Purpose', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  _buildSegmentedControl(),
                  const SizedBox(height: 24),

                  const Text('Property Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildChip('Apartment', _selectedPropertyType == 'Apartment', () => setState(() => _selectedPropertyType = 'Apartment')),
                      _buildChip('House', _selectedPropertyType == 'House', () => setState(() => _selectedPropertyType = 'House')),
                      _buildChip('Villa', _selectedPropertyType == 'Villa', () => setState(() => _selectedPropertyType = 'Villa')),
                      _buildChip('Plot', _selectedPropertyType == 'Plot', () => setState(() => _selectedPropertyType = 'Plot')),
                      _buildChip('Commercial', _selectedPropertyType == 'Commercial', () => setState(() => _selectedPropertyType = 'Commercial')),
                      _buildChip('Office', _selectedPropertyType == 'Office', () => setState(() => _selectedPropertyType = 'Office')),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('₹0', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                      Text('₹5 Cr', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      activeTrackColor: AppColors.primaryBlue,
                      inactiveTrackColor: AppColors.borderLight,
                      thumbColor: AppColors.primaryBlue,
                      overlayColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                    ),
                    child: Slider(
                      value: _priceValue,
                      onChanged: (val) => setState(() => _priceValue = val),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text('BHK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleChip(1),
                      _buildCircleChip(2),
                      _buildCircleChip(3),
                      _buildCircleChip(4),
                      _buildCircleChip(5),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text('Furnishing', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildChip('Any', _selectedFurnishing == 'Any', () => setState(() => _selectedFurnishing = 'Any')),
                      _buildChip('Furnished', _selectedFurnishing == 'Furnished', () => setState(() => _selectedFurnishing = 'Furnished')),
                      _buildChip('Semi', _selectedFurnishing == 'Semi', () => setState(() => _selectedFurnishing = 'Semi')),
                      _buildChip('Unfurnished', _selectedFurnishing == 'Unfurnished', () => setState(() => _selectedFurnishing = 'Unfurnished')),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            color: AppColors.white,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _purposeIndex = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _purposeIndex == 0 ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text('Buy', style: TextStyle(color: _purposeIndex == 0 ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _purposeIndex = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _purposeIndex == 1 ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text('Rent', style: TextStyle(color: _purposeIndex == 1 ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.borderLight),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCircleChip(int bhk) {
    bool isSelected = _selectedBHK == bhk;
    String label = bhk == 5 ? '5+' : '$bhk';
    return GestureDetector(
      onTap: () => setState(() => _selectedBHK = bhk),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.borderLight),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
