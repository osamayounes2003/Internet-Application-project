import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Notifications/FireBase_Services.dart';
import 'Notifications/Notifications_Services.dart';
import 'Routes/app_routes.dart';
import 'SharedPreferences/shared_preferences_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  bool isLoggedIn = await sharedPreferencesService.getIsLoggedIn();
  String? userRole = await sharedPreferencesService.getRole();

  await initializeFirebase();
  await requestNotificationPermission();
  setupFirebaseMessaging();

  runApp(MyApp(isLoggedIn: isLoggedIn, userRole: userRole));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userRole;

  MyApp({super.key, required this.isLoggedIn, this.userRole});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      initialRoute:
          isLoggedIn ? (userRole == 'USER' ? 'Groups' : 'home_user') : 'login',
      getPages: AppRoutes.routes,
    );
  }
}
