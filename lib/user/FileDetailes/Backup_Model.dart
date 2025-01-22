class BackupModel {
  final int id;
  final String name;
  final String createdAt;

  BackupModel({required this.id, required this.name, required this.createdAt});

  factory BackupModel.fromJson(Map<String, dynamic> json) {
    return BackupModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }
}
