class FileModel {
  final int id;
  final String? name;
  final String? url;
  final String? status;

  final int folderId;

  FileModel({
    required this.id,
    required this.name,
    required this.url,
    this.status,

    required this.folderId,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    // Assuming folder is a nested object
    return FileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      url: json['url'] ?? '',
      status: json['status'],

      folderId: json['folderId'] ?? 0, // Extract folderId from nested object
    );
  }
}