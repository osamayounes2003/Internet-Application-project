class CreateGroupModel {
  int? id;
  String? name;
  List<dynamic>? listOfFiles;
  List<dynamic>? listOfUsers;

  CreateGroupModel({this.id, this.name, this.listOfFiles, this.listOfUsers});

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) {
    return CreateGroupModel(
      id: json['id'],
      name: json['name'],
      listOfFiles: json['listOfFiles'],
      listOfUsers: json['listOfUsers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'listOfFiles': listOfFiles,
      'listOfUsers': listOfUsers,
    };
  }
}
