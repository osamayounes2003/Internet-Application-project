import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Auth/SharedPreferences/shared_preferences_service.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferencesService = SharedPreferencesService();

  bool isLoggedIn = await sharedPreferencesService.getIsLoggedIn();
  String? userRole = await sharedPreferencesService.getRole();

  runApp(MyApp(isLoggedIn: isLoggedIn, userRole: userRole));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userRole;

  MyApp({super.key, required this.isLoggedIn, this.userRole});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      initialRoute: isLoggedIn
          ? (userRole == 'USER' ? AppRoutes.homeUser : AppRoutes.login)
          : AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
