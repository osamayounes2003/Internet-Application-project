class FileModel {
  final int id;
  final String name;
  final String url;
  final int folderId ;
  final String status;

  FileModel( {
    required this.folderId,
    required this.id,
    required this.name,
    required this.url,
    required this.status,

  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      folderId : json["folderId"],
      id: json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
    );
  }
}
