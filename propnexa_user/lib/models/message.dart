class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
  });
}

class Conversation {
  final String id;
  final String userId;
  final String adminId;
  final String propertyId; // Optional context
  final Message lastMessage;
  final int unreadCount;

  Conversation({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.propertyId,
    required this.lastMessage,
    this.unreadCount = 0,
  });
}

