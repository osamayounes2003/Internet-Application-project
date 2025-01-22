import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewPassword_Controller extends GetxController {
   String emailAddress;

  NewPassword_Controller({required this.emailAddress});

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> resetPassword() async {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      try {
        var request = http.Request(
          'POST',
          Uri.parse(
            'http://195.88.87.77:8888/api/v1/auth/change-password?email=${emailAddress}&password=${passwordController.text}',
          ),
        );

        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar('Success', 'Password reset successful!',
              backgroundColor: Colors.green, colorText: Colors.white);

          Get.offAllNamed("/profile");
        } else {
          Get.snackbar(
              'Error', response.reasonPhrase ?? 'Failed to reset password',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred. Please try again later.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}
