import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../OTP/OTP_Screen.dart';
import 'SignUp_Model.dart';

class SignUp_Controller extends GetxController {

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isPasswordVisible = false.obs;


  void validateAndSignUp() async{
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
    else {
      await signUp();
      // Get.snackbar('Success', 'Sign up successful!',
      //     backgroundColor: Colors.green, colorText: Colors.white);
      // Get.to(() => OTP_Screen(nextRoute: '/login',emailAddress: emailController.text,));
    }
  }

  Future<void> signUp() async {
    var headers = {'Content-Type': 'application/json'};
    SignupModel signupModel = SignupModel(
      fullname: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    var request = http.Request(
      'POST',
      Uri.parse('http://195.88.87.77:8888/api/v1/auth/register'),
    );

    request.body = json.encode(signupModel.toJson());
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode==201) {
        print(await response.stream.bytesToString());
        Get.snackbar('Success', 'Sign up successful!',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() => OTP_Screen(nextRoute: '/login',emailAddress: emailController.text,));
      } else {
        Get.snackbar('Error', response.reasonPhrase ?? 'Unknown error',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign up: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
