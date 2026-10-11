import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/property.dart';
import '../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class FeaturedPropertyCard extends StatelessWidget {
  final Property property;

  const FeaturedPropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0, locale: 'en_IN');
    
    return GestureDetector(
      onTap: () => context.push('/property/${property.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Stack(
              children: [
                Container(
                  height: 200, // Large image
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                    image: property.images.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(property.images.first),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey.shade200,
                  ),
                  child: property.images.isEmpty ? const Center(child: Icon(Icons.image, color: Colors.grey)) : null,
                ),
                // Featured Badge
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.workspace_premium, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text('Featured', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                // Heart Button
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, color: AppColors.textSecondary, size: 20),
                  ),
                ),
                // Image Count
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.image_outlined, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text('1/10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Bottom Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatCurrency.format(property.price),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (property.status == PropertyStatus.published)
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: AppColors.statusApproved,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check, color: Colors.white, size: 10),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'PropNexa Verified',
                              style: TextStyle(color: AppColors.statusApproved, fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    property.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildFeatureIcon(Icons.hotel, '${property.bhk ?? 3} Beds'),
                      const SizedBox(width: 24),
                      _buildFeatureIcon(Icons.bathtub_outlined, '${property.bathrooms ?? 2} Baths'),
                      const SizedBox(width: 24),
                      _buildFeatureIcon(Icons.aspect_ratio, '${property.area} sqft'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
