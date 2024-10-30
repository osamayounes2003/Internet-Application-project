class User {
  final int id;
  final String fullname;
  final String email;
  final String role;

  User({required this.id, required this.fullname, required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}
