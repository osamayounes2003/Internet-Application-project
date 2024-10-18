class FileModel {
  final int id;
  final String name;
  final String url;
  final String status;

  FileModel({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
    );
  }
}
