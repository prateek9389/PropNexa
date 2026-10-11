class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImageUrl;
  final String? city;
  final DateTime joinedDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageUrl,
    this.city,
    required this.joinedDate,
  });
}

