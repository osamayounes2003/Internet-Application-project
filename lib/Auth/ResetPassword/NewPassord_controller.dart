import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassword_Controller extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void resetPassword() {
    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      Get.snackbar('Success', 'Password reset successful!',
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }
}
