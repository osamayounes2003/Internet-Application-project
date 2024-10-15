import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../OTP/OTP_Screen.dart';

class SignUp_Controller extends GetxController {

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isPasswordVisible = false.obs;

  // final List<String> items = ['Admin', 'User'];
  // var selectedItem = 'User'.obs;

  void validateAndSignUp() {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    // Validate email format
    else if (!regExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    // Check password length
    else if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    // If all validations pass
    else {
      Get.snackbar('Success', 'Sign up successful!',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() => OTP_Screen(nextRoute: '/home')); // الانتقال إلى واجهة OTP وتحديد وجهة newPassword
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
