import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../color_.dart';

class ThemeController extends GetxController {
  var currentTheme = 'light'.obs;

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    currentTheme.value = prefs.getString('currentTheme') ?? 'light';
    applyTheme(currentTheme.value);
  }

  void setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    currentTheme.value = theme;
    await prefs.setString('currentTheme', theme);
    applyTheme(theme);
  }
  void applyTheme(String theme) {
    switch (theme) {
      case 'dark':
        Get.changeThemeMode(ThemeMode.dark);
        break;
      case 'light':
        Get.changeThemeMode(ThemeMode.light);
        break;
      case 'blueNavy':
        Get.changeTheme(
          ThemeData(
            scaffoldBackgroundColor: AppColors.blueNavyBackground2,
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: AppColors.blueNavyFont),
            ),
            buttonTheme: ButtonThemeData(buttonColor: AppColors.blueNavyButton),
            cardColor: AppColors.blueNavyBackground2, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: AppColors.blueNavyBackground),
          ),
        );
        break;
      case 'golden':
        Get.changeTheme(
          ThemeData(
            scaffoldBackgroundColor: AppColors.goldenBackground2,
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: AppColors.goldenFont),
            ),
            buttonTheme: ButtonThemeData(buttonColor: AppColors.goldenButton),
            cardColor: AppColors.goldenBackground2, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber).copyWith(background: AppColors.goldenBackground),
          ),
        );
        break;
      default:
        Get.changeTheme(ThemeData.light());
        break;
    }
  }

  ThemeData getThemeData() {
    switch (currentTheme.value) {
      case 'dark':
        return ThemeData.dark();
      case 'blueNavy':
        return ThemeData(
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.blueGrey.shade900,
        );
      case 'golden':
        return ThemeData(
          primaryColor: Colors.amber,
          scaffoldBackgroundColor: Colors.amber.shade100,
        );
      default:
        return ThemeData.light();
    }
  }

}

