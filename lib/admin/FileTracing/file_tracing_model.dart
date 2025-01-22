class FileTracingModel {
  final int id;
  final int fileId;
  final int userId;
  final String type;
  final DateTime createdAt;

  FileTracingModel({
    required this.id,
    required this.fileId,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  factory FileTracingModel.fromJson(Map<String, dynamic> json) {
    return FileTracingModel(
      id: json['id'],
      fileId: json['fileId'],
      userId: json['userId'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
