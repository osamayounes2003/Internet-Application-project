class LoginModel {
  final int id;
  final String fullname;
  final String email;
  final String role;
  final String token;
  final String refreshToken;

  LoginModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
    required this.token,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }
}
