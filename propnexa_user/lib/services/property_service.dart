import 'package:flutter/foundation.dart';
import '../models/property.dart';
import '../models/requirement.dart';
import 'mock_data.dart';

abstract class IPropertyService {
  Future<List<Property>> getProperties();
  Future<List<Property>> getFeaturedProperties();
  Future<List<Property>> getPropertiesByUserId(String userId);
  Future<Property?> getPropertyById(String id);
  Future<void> addProperty(Property property);
  Future<void> updatePropertyStatus(String propertyId, PropertyStatus newStatus, {String? message});
}

class MockPropertyService implements IPropertyService {
  final List<Property> _properties = List.from(MockData.properties);

  @override
  Future<List<Property>> getProperties() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _properties.where((p) => p.status == PropertyStatus.published).toList();
  }

  @override
  Future<List<Property>> getFeaturedProperties() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _properties.where((p) => p.status == PropertyStatus.published && p.isVerified).toList();
  }

  @override
  Future<List<Property>> getPropertiesByUserId(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _properties.where((p) => p.ownerId == userId).toList();
  }

  @override
  Future<Property?> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addProperty(Property property) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _properties.insert(0, property);
  }

  @override
  Future<void> updatePropertyStatus(String propertyId, PropertyStatus newStatus, {String? message}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _properties.indexWhere((p) => p.id == propertyId);
    if (index != -1) {
      final p = _properties[index];
      _properties[index] = Property(
        id: p.id,
        title: p.title,
        description: p.description,
        purpose: p.purpose,
        type: p.type,
        price: p.price,
        location: p.location,
        bhk: p.bhk,
        bathrooms: p.bathrooms,
        area: p.area,
        furnishing: p.furnishing,
        amenities: p.amenities,
        images: p.images,
        status: newStatus,
        postedDate: p.postedDate,
        ownerId: p.ownerId,
        isVerified: p.isVerified,
        adminMessage: message ?? p.adminMessage,
      );
    }
  }
}

