enum NotificationType {
  property,
  requirement,
  chat,
  visit,
  system,
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? relatedItemId; // Property ID, Chat ID, etc.

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.relatedItemId,
  });
}

