import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SharedPreferences/shared_preferences_service.dart';
import 'LogInModel.dart';

class LogIn_Controller extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (!_validateInput(email, password)) return;

    isLoading.value = true;
    var url = Uri.parse('http://195.88.87.77:8888/api/v1/auth/login');

    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "email": email,
      "password": password,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        LoginModel user = LoginModel.fromJson(data);

        await _sharedPreferencesService.saveUserData(
          id: user.id,
          fullname: user.fullname,
          email: user.email,
          role: user.role,
          token: user.token,
          refreshToken: user.refreshToken,
        );

        await _sharedPreferencesService.setIsLoggedIn(true);

        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );

        print('^^^^^^^^^^^^ Token ^^^^^^^^^^^^: ${user.token}');

        if (user.role == 'USER') {
          Get.offAllNamed('home_user');
        } else if (user.role == 'ADMIN') {
          Get.offAllNamed('home_admin');
        } else {
          Get.snackbar('Error', 'Unknown user role',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Invalid email or password',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("errorrrrrrrrrr: $e");
      Get.snackbar('Error', 'Failed to connect to server',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInput(String email, String password) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (!regExp.hasMatch(email)) {
      Get.snackbar('Error', 'Please enter a valid email',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }
}
