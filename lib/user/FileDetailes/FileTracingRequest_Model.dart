class FileTracingRequest {
  final int fileId;
  final int userId;
  final String type;
  final DateTime startDate;
  final DateTime endDate;

  FileTracingRequest({
    required this.fileId,
    required this.userId,
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'fileId': fileId,
      'userId': userId,
      'type': type,
      'start': startDate.toIso8601String(),
      'end': endDate.toIso8601String(),
    };
  }
}
