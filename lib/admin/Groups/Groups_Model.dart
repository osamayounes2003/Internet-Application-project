class Groups {
  final int id;
  final String name;
  final Owner owner;
  final List<String> listOfUsers;
  final List<String> listOfFiles;

  Groups({
    required this.id,
    required this.name,
    required this.owner,
    required this.listOfUsers,
    required this.listOfFiles,
  });

  factory Groups.fromJson(Map<String, dynamic> json) {
    return Groups(
      id: json['id'],
      name: json['name'],
      owner: Owner.fromJson(json['owner']),
      listOfUsers: List<String>.from(json['usersInFolder'].map((user) => user['fullname'])),
      listOfFiles: List<String>.from(json['files'].map((file) => file['name'])),
    );
  }
}

class Owner {
  final int id;
  final String fullname;
  final String email;
  final String role;

  Owner({required this.id, required this.fullname, required this.email, required this.role});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}



// import '../CreateGroup/AddMembers/usersModel.dart';
//
// class Groups {
//   final int id;
//   final String name;
//   late final List<String>? listOfFiles;
//   final List<User> listOfUsers;
//
//   Groups({
//     required this.id,
//     required this.name,
//     required this.listOfFiles,
//     required this.listOfUsers,
//   });
//
//   factory Groups.fromJson(Map<String, dynamic> json) {
//     return Groups(
//       id: json['id'],
//       name: json['name'],
//       listOfFiles: json['listOfFiles'] != null
//           ? List<String>.from(json['listOfFiles'].map((file) => file.toString()))
//           : [],
//       listOfUsers: json['listOfUsers'] != null
//           ? List<User>.from(json['listOfUsers'].map((user) => User.fromJson(user)))
//           : [],
//     );
//   }
// }
