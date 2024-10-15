import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogIn_Controller extends GetxController {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isPasswordVisible = false.obs;



  void validateAndSignUp() {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (emailController.text.isEmpty ||
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
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
