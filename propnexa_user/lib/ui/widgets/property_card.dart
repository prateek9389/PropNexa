import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/property.dart';
import '../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final bool isHorizontal;

  const PropertyCard({super.key, required this.property, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0, locale: 'en_IN');
    
    if (isHorizontal) {
      // Logic for horizontal card (Explore screen) remains...
      return _buildHorizontalCard(context, formatCurrency);
    }
    
    // Logic for vertical card (Recommended for You)
    return GestureDetector(
      onTap: () => context.push('/property/${property.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, color: AppColors.textSecondary, size: 16),
                  ),
                ),
              ],
            ),
            
            // Bottom Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatCurrency.format(property.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    property.title,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 10, color: AppColors.textSecondary),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          property.location,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (property.status == PropertyStatus.published)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.statusApproved,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 8),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'PropNexa Verified',
                          style: TextStyle(color: AppColors.statusApproved, fontSize: 10, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, NumberFormat formatCurrency) {
    return GestureDetector(
      onTap: () => context.push('/property/${property.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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
                  // Optional Featured Badge (simulate for first item if needed, assuming property.isFeatured exists, using fallback)
                  if (property.id == 'prop1') // Mocking featured for first property
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.workspace_premium, color: Colors.amber, size: 12),
                            SizedBox(width: 4),
                            Text('Featured', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                  // Image Count
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.image_outlined, color: Colors.white, size: 10),
                          SizedBox(width: 4),
                          Text('1/10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            property.title,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.favorite_border, color: AppColors.textSecondary, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textSecondary),
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
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatCurrency.format(property.price) + (property.isRent ? '/month' : ''),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryBlue,
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
                                child: const Icon(Icons.check, color: Colors.white, size: 8),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'PropNexa Verified',
                                style: TextStyle(color: AppColors.statusApproved, fontSize: 10, fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.hotel, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('${property.bhk ?? 3} Beds', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.bathtub_outlined, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('${property.bathrooms ?? 2} Baths', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.aspect_ratio, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('${property.area} sqft', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
