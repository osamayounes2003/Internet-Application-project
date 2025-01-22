class PendingFileModel {
  final int id;
  final String name;
  final String url;
  final String status;
  final String? bookedUser;
  final int folderId;

  PendingFileModel({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
    this.bookedUser,
    required this.folderId,
  });

  factory PendingFileModel.fromJson(Map<String, dynamic> json) {
    return PendingFileModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
      bookedUser: json['bookedUser']?['fullname'],
      folderId: json['folderId'],
    );
  }
}
