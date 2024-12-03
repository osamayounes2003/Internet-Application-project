import 'dart:convert';
import 'package:file_manager_internet_applications_project/Routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../SharedPreferences/shared_preferences_service.dart';

class RefreshTokenController extends GetxController {
  var isLoading = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    super.onInit();
refreshToken();
  }



  Future<void> refreshToken() async {
    isLoading.value = true;
    var url = Uri.parse('http://195.88.87.77:8888/api/v1/auth/refresh');
    String? token = await _sharedPreferencesService.getToken() ;
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    };

    var body = json.encode({
      'refreshToken': await _sharedPreferencesService.getRefreshToken(),
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        var data = json.decode(response.body);
        print("osama makes refresh token : $data");
       _sharedPreferencesService.saveRefreshToken(data['refreshToken']);
       var refreshToken= await _sharedPreferencesService.getRefreshToken() ;
       print("refreshToken : $refreshToken");
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to connect to server',
          backgroundColor: Colors.red, colorText: Colors.white);
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoading.value = false;
    }
  }
}