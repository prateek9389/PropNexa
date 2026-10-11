enum PropertyStatus {
  draft,
  submitted,
  underReview,
  changesRequested,
  approved,
  published,
  rejected,
}

enum PropertyPurpose {
  buy,
  rent,
}

enum PropertyType {
  apartment,
  house,
  villa,
  plot,
  commercial,
  office,
  shop,
}

class Property {
  final String id;
  final String title;
  final String description;
  final PropertyPurpose purpose;
  final PropertyType type;
  final double price;
  final String location;
  final int? bhk;
  final int? bathrooms;
  final double area; // in sq.ft
  final String furnishing;
  final List<String> amenities;
  final List<String> images;
  final PropertyStatus status;
  final DateTime postedDate;
  final String ownerId;
  final bool isVerified;
  final String? adminMessage;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.purpose,
    required this.type,
    required this.price,
    required this.location,
    this.bhk,
    this.bathrooms,
    required this.area,
    required this.furnishing,
    required this.amenities,
    required this.images,
    required this.status,
    required this.postedDate,
    required this.ownerId,
    this.isVerified = false,
    this.adminMessage,
  });

  bool get isRent => purpose == PropertyPurpose.rent;
}

