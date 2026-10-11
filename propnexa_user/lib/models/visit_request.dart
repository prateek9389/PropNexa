enum VisitStatus {
  pending,
  accepted,
  rejected,
  completed,
  cancelled,
}

class VisitRequest {
  final String id;
  final String propertyId;
  final String userId;
  final DateTime requestedDate;
  final String requestedTime;
  final String? message;
  final VisitStatus status;

  VisitRequest({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.requestedDate,
    required this.requestedTime,
    this.message,
    required this.status,
  });
}

