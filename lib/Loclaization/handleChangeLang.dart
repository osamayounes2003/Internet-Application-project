
import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void changeLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final currentLocale = Get.locale?.languageCode;

  if (currentLocale == 'en') {
    Get.updateLocale(Locale('ar'));
    prefs.setString('language', 'ar');
  } else {
    Get.updateLocale(Locale('en'));
    prefs.setString('language', 'en');
  }

  updateTextDirection();
}

void updateTextDirection() {
  final locale = Get.locale?.languageCode;

  if (locale == 'ar') {
    Get.updateLocale(Locale('ar', 'AE'));
  } else {
    Get.updateLocale(Locale('en', 'US'));
  }
}
