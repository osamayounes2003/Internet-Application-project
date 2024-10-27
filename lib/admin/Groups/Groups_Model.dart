import '../CreateGroup/AddMembers/usersModel.dart';

class Groups {
  final int id;
  final String name;
  late final List<String>? listOfFiles;
  final List<User> listOfUsers;

  Groups({
    required this.id,
    required this.name,
    required this.listOfFiles,
    required this.listOfUsers,
  });

  factory Groups.fromJson(Map<String, dynamic> json) {
    return Groups(
      id: json['id'],
      name: json['name'],
      listOfFiles: json['listOfFiles'] != null
          ? List<String>.from(json['listOfFiles'].map((file) => file.toString()))
          : [],
      listOfUsers: json['listOfUsers'] != null
          ? List<User>.from(json['listOfUsers'].map((user) => User.fromJson(user)))
          : [],
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
//     print('Received listOfFiles: ${json['listOfFiles']}');
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
