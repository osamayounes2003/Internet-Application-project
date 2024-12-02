import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Loclaization/translations.dart';
import 'Notifications/FireBase_Services.dart';
import 'Notifications/Notifications_Services.dart';
import 'Routes/app_routes.dart';
import 'SharedPreferences/shared_preferences_service.dart';
import 'Theme/ThemeController.dart';
import 'user/HomeUser/HomeUser_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final SharedPreferencesService sharedPreferencesService =
  SharedPreferencesService();
  bool isLoggedIn = await sharedPreferencesService.getIsLoggedIn();
  String? userRole = await sharedPreferencesService.getRole();

  String? savedLanguage = prefs.getString('language') ?? 'en';
  Locale initialLocale = Locale(savedLanguage);

  await initializeFirebase();
  await requestNotificationPermission();
  setupFirebaseMessaging();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    userRole: userRole,
    initialLocale: initialLocale,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userRole;
  final Locale initialLocale;

  MyApp({
    super.key,
    required this.isLoggedIn,
    this.userRole,
    required this.initialLocale,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        translations: MyTranslations(),
        locale: initialLocale,
        fallbackLocale: Locale('en'),
        theme: themeController.getThemeData(),
        home: HomeUser_Screen(),
        initialRoute: isLoggedIn
            ? (userRole == 'USER' ? 'Groups' : 'home_user')
            : 'login',
        getPages: AppRoutes.routes,
      );
    });
  }
}
