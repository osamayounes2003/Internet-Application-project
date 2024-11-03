class Groups {
  final int id;
  final String name;
  final Owner? owner;
  final List<UserInFolder> listOfUsers;
  final List<String> listOfFiles;


  Groups({
    required this.id,
    required this.name,
    this.owner,
    required this.listOfUsers,
    required this.listOfFiles,
  });

  factory Groups.fromJson(Map<String, dynamic> json) {
    return Groups(
      id: json['id'],
      name: json['name'],
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
      listOfUsers: json['usersInFolder'] != null
          ? List<UserInFolder>.from(json['usersInFolder'].map((user) => UserInFolder.fromJson(user)))
          : [],
      listOfFiles: json['files'] != null
          ? List<String>.from(json['files'].map((file) => file['name'] ?? ""))
          : [],
    );
  }
}
class UserInFolder {
  final int id;
  final String fullname;

  UserInFolder({required this.id, required this.fullname});

  factory UserInFolder.fromJson(Map<String, dynamic> json) {
    return UserInFolder(
      id: json['user']['id'],
      fullname: json['user']['fullname'] ?? "",
    );
  }
}

class Owner {
  final int id;
  final String fullname;
  final String email;
  final String role;

  Owner({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}