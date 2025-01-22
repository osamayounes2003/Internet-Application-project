class OtpModel {
  String email;
  String verificationCode;

  OtpModel({required this.email, required this.verificationCode});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'verificationCode': verificationCode,
    };
  }
}
