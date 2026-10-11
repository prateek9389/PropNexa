import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';

class SellPropertyForm extends StatefulWidget {
  const SellPropertyForm({super.key});

  @override
  State<SellPropertyForm> createState() => _SellPropertyFormState();
}

class _SellPropertyFormState extends State<SellPropertyForm> {
  int _currentStep = 1;
  final int _totalSteps = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Sell Property'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Step Indicator
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_totalSteps, (index) {
                final step = index + 1;
                final isActive = _currentStep == step;
                final isCompleted = _currentStep > step;
                
                return Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primaryBlue : AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive || isCompleted ? AppColors.primaryBlue : AppColors.borderLight,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: AppColors.primaryBlue, size: 18)
                        : Text(
                            step.toString(),
                            style: TextStyle(
                              color: isActive ? AppColors.white : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Basic Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  const SizedBox(height: 16),
                  
                  const Text('Property Title', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: InputDecoration(hintText: 'e.g. Luxury 3 BHK Apartment'),
                  ),
                  const SizedBox(height: 16),
                  
                  const Text('Property Type', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  _buildDropdown('Apartment'),
                  const SizedBox(height: 16),
                  
                  const Text('BHK', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  _buildDropdown('3 BHK'),
                  const SizedBox(height: 16),
                  
                  const Text('Bathrooms', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  _buildDropdown('2'),
                  const SizedBox(height: 16),
                  
                  const Text('Built-up Area (sq ft)', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: InputDecoration(hintText: 'e.g. 1450'),
                    keyboardType: TextInputType.number,
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
              onPressed: () {
                if (_currentStep < _totalSteps) {
                  setState(() => _currentStep++);
                } else {
                  _showSuccessDialog();
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          items: [
            DropdownMenuItem(value: value, child: Text(value)),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(32),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.statusApproved,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'Property Submitted!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your property has been submitted\nfor admin review.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Property ID', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('PN-10245', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  const Text('Status', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text('Pending Review', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.statusPending)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Track Submission'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go(AppRoutes.mainNavigation),
              child: const Text('Go Home', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
