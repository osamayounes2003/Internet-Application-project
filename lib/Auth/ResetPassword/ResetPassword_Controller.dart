import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../OTP/OTP_Screen.dart';

class ResetPassword_Controller extends GetxController {
  var emailController = TextEditingController();

  void sendVerificationCode() {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (!regExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      Get.snackbar('Success', 'Verification code sent!',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() => OTP_Screen(nextRoute: '/newPassword'));

    }
  }
}
