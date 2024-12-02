class UserInFolder {
  final int id;
  final String fullname;
  final String email;
  final String role;

  UserInFolder({required this.id, required this.fullname, required this.email, required this.role});

  factory UserInFolder.fromJson(Map<String, dynamic> json) {
    return UserInFolder(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}
