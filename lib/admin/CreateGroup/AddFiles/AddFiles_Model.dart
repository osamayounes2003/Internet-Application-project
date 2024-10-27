class FileModel {
  final int id;
  final String name;
  final String url;
  final String status;
  final int? bookedUser;

  FileModel({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
    this.bookedUser,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
      bookedUser: json['bookedUser'] != null ? json['bookedUser'] as int : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'status': status,
      'bookedUser': bookedUser,
    };
  }
}
