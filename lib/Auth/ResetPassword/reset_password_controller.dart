import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // لتحويل البيانات

import '../OTP/otp_screen.dart';

class ResetPassword_Controller extends GetxController {
  var emailController = TextEditingController();

  Future<void> sendVerificationCode() async {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (!regExp.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      try {
        var request = http.Request(
            'POST',
            Uri.parse(
                'http://195.88.87.77:8888/api/v1/auth/send-code?email=${emailController.text}'));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
            Get.snackbar('Success', 'Verification code sent!',
                backgroundColor: Colors.green, colorText: Colors.white);

            Get.to(() => OTP_Screen(
                  nextRoute: '/newPassword',
                  emailAddress: emailController.text,
                ));
        } else {
          Get.snackbar('Error', response.reasonPhrase ?? 'Unknown error',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        print(e);
        Get.snackbar('Error', 'Something went wrong. Try again.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}
