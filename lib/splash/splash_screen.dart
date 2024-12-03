import 'package:file_manager_internet_applications_project/Auth/refresh_token/refresh_token_controller.dart';
import 'package:file_manager_internet_applications_project/Routes/app_routes.dart';
import 'package:file_manager_internet_applications_project/user/HomeUser/HomeUser_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../SharedPreferences/shared_preferences_service.dart';
import '../color_.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RefreshTokenController controller = Get.put(RefreshTokenController());
    final SharedPreferencesService _sharedPreferencesService =
    SharedPreferencesService();
    Future.delayed(const Duration(seconds: 3),
            () async {
      String? refreshToken = await _sharedPreferencesService.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        controller.refreshToken();
        Get.offAllNamed(AppRoutes.homeUser);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });

    return  Scaffold(
      backgroundColor: color_.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  Text(
              'Welcome to file manager app',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
           color: color_.darkWhite,
            ),
          ],
        ),
      ),
    );
  }
}