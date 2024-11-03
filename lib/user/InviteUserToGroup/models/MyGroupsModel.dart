class MyGroupsModel {
  final int id;
  final String name;
  final Owner owner;
  final List<File> files;
  final List<UserInFolder> usersInFolder;

  MyGroupsModel({
    required this.id,
    required this.name,
    required this.owner,
    required this.files,
    required this.usersInFolder,
  });

  factory MyGroupsModel.fromJson(Map<String, dynamic> json) {
    var filesList = json['files'] as List;
    var usersInFolderList = json['usersInFolder'] as List;

    return MyGroupsModel(
      id: json['id'],
      name: json['name'],
      owner: Owner.fromJson(json['owner']),
      files: filesList.map((file) => File.fromJson(file)).toList(),
      usersInFolder: usersInFolderList.map((user) => UserInFolder.fromJson(user)).toList(),
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

class File {
  final int id;
  final String name;
  final String url;
  final String status;
  final int? bookedUser;
  final int folderId;

  File({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
    this.bookedUser,
    required this.folderId,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
      bookedUser: json['bookedUser'],
      folderId: json['folderId'],
    );
  }
}

class UserInFolder {
  final int id;
  final String status;
  final User user;
  final String createdAt;

  UserInFolder({
    required this.id,
    required this.status,
    required this.user,
    required this.createdAt,
  });

  factory UserInFolder.fromJson(Map<String, dynamic> json) {
    return UserInFolder(
      id: json['id'],
      status: json['status'],
      user: User.fromJson(json['user']),
      createdAt: json['createdAt'],
    );
  }
}

class User {
  final int id;
  final String fullname;
  final String email;
  final String role;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}
