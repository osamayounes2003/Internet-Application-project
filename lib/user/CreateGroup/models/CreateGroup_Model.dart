class CreateGroupModel {
  int? id;
  String? name;
  Owner? owner;

  CreateGroupModel({this.id, this.name, this.owner});

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) {
    return CreateGroupModel(
      id: json['id'],
      name: json['name'],
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner?.toJson(),
    };
  }
}

class Owner {
  int? id;
  String? fullname;
  String? email;
  String? role;

  Owner({this.id, this.fullname, this.email, this.role});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'role': role,
    };
  }
}
