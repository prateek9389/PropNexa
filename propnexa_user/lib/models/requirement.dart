import 'property.dart';

enum RequirementStatus {
  draft,
  submitted,
  underReview,
  changesRequested,
  approved,
  published,
  rejected,
}

class Requirement {
  final String id;
  final String userId;
  final PropertyPurpose purpose;
  final PropertyType propertyType;
  final String location;
  final double minBudget;
  final double maxBudget;
  final int? bhk;
  final double minArea;
  final double maxArea;
  final String furnishing;
  final List<String> amenities;
  final String description;
  final RequirementStatus status;
  final DateTime postedDate;
  final String? adminComments;

  Requirement({
    required this.id,
    required this.userId,
    required this.purpose,
    required this.propertyType,
    required this.location,
    required this.minBudget,
    required this.maxBudget,
    this.bhk,
    required this.minArea,
    required this.maxArea,
    required this.furnishing,
    required this.amenities,
    required this.description,
    required this.status,
    required this.postedDate,
    this.adminComments,
  });
}

