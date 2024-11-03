class Users {
  final int id;
  final String fullname;
  final String email;
  final String role;

  Users({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}
