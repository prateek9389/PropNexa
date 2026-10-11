import '../models/property.dart';
import '../models/user.dart';
import '../models/requirement.dart';

class MockData {
  static final User currentUser = User(
    id: 'u1',
    name: 'Prateek Kumar',
    email: 'prateek@example.com',
    phone: '+91 9876543210',
    city: 'Noida',
    joinedDate: DateTime.now().subtract(const Duration(days: 100)),
  );

  static final List<Property> properties = [
    Property(
      id: 'prop1',
      title: 'Luxury 3 BHK in Supertech Capetown',
      description: 'A beautiful and spacious 3 BHK apartment in the heart of Noida. Close to metro and schools.',
      purpose: PropertyPurpose.buy,
      type: PropertyType.apartment,
      price: 12000000, // 1.2 Cr
      location: 'Sector 74, Noida',
      bhk: 3,
      bathrooms: 3,
      area: 1650,
      furnishing: 'Semi Furnished',
      amenities: ['Parking', 'Lift', 'Security', 'Gym', 'Swimming Pool', 'Power Backup'],
      images: [
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
        'https://images.unsplash.com/photo-1502672260266-1c1de2d96674?w=800',
      ],
      status: PropertyStatus.published,
      postedDate: DateTime.now().subtract(const Duration(days: 5)),
      ownerId: 'u2',
      isVerified: true,
    ),
    Property(
      id: 'prop2',
      title: 'Independent Villa in Greater Noida',
      description: 'Newly built villa with a private garden and modern interiors.',
      purpose: PropertyPurpose.buy,
      type: PropertyType.villa,
      price: 25000000, // 2.5 Cr
      location: 'Alpha 1, Greater Noida',
      bhk: 4,
      bathrooms: 4,
      area: 2500,
      furnishing: 'Fully Furnished',
      amenities: ['Parking', 'Security', 'Garden', 'CCTV', 'Balcony'],
      images: [
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      ],
      status: PropertyStatus.published,
      postedDate: DateTime.now().subtract(const Duration(days: 12)),
      ownerId: 'u3',
      isVerified: true,
    ),
    Property(
      id: 'prop3',
      title: '2 BHK Apartment for Rent',
      description: 'Well-maintained apartment perfect for small families.',
      purpose: PropertyPurpose.rent,
      type: PropertyType.apartment,
      price: 25000, // 25k/month
      location: 'Indirapuram, Ghaziabad',
      bhk: 2,
      bathrooms: 2,
      area: 1100,
      furnishing: 'Unfurnished',
      amenities: ['Lift', 'Security', 'Power Backup'],
      images: [
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800',
      ],
      status: PropertyStatus.published,
      postedDate: DateTime.now().subtract(const Duration(days: 2)),
      ownerId: 'u4',
      isVerified: false,
    ),
    Property(
      id: 'prop4',
      title: 'My Draft Property',
      description: 'Pending details',
      purpose: PropertyPurpose.buy,
      type: PropertyType.apartment,
      price: 7500000,
      location: 'Sector 62, Noida',
      bhk: 2,
      bathrooms: 2,
      area: 1200,
      furnishing: 'Semi Furnished',
      amenities: ['Parking'],
      images: [],
      status: PropertyStatus.draft,
      postedDate: DateTime.now(),
      ownerId: 'u1',
      isVerified: false,
    ),
    Property(
      id: 'prop5',
      title: 'Pending Review Office Space',
      description: 'Commercial office space in a prime location.',
      purpose: PropertyPurpose.rent,
      type: PropertyType.office,
      price: 45000,
      location: 'Connaught Place, Delhi',
      area: 800,
      furnishing: 'Fully Furnished',
      amenities: ['Lift', 'Security', 'CCTV', 'Power Backup'],
      images: [
        'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
      ],
      status: PropertyStatus.underReview,
      postedDate: DateTime.now().subtract(const Duration(hours: 10)),
      ownerId: 'u1',
      isVerified: false,
    ),
  ];

  static final List<Requirement> requirements = [
    Requirement(
      id: 'req1',
      userId: 'u1',
      purpose: PropertyPurpose.buy,
      propertyType: PropertyType.apartment,
      location: 'Noida / Greater Noida',
      minBudget: 5000000,
      maxBudget: 8000000,
      bhk: 3,
      minArea: 1200,
      maxArea: 1600,
      furnishing: 'Semi Furnished',
      amenities: ['Parking', 'Lift', 'Security'],
      description: 'Looking for a 3 BHK near a metro station with good society amenities.',
      status: RequirementStatus.published,
      postedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];
}

