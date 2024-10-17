import 'package:file_manager_internet_applications_project/Auth/LogIN/LogIn_Screen.dart';
import 'package:file_manager_internet_applications_project/Auth/OTP/OTP_Screen.dart';
import 'package:file_manager_internet_applications_project/Auth/ResetPassword/NewPassword_Screen.dart';
import 'package:file_manager_internet_applications_project/Auth/ResetPassword/ResetPassword_Screen.dart';
import 'package:file_manager_internet_applications_project/user/HomeUser/HomeUser_Screen.dart';
import 'package:file_manager_internet_applications_project/user/UploadFile/UploadFile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/SharedPreferences/shared_preferences_service.dart';
import 'Auth/SignUp/SignUp_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
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
          ? (userRole == 'USER' ? 'home_user' : 'home_admin')
          : 'login',
      getPages: [
        GetPage(name: '/login', page: () => LogIn_Screen()),
        GetPage(name: '/signup', page: () => SignUp_Screen()),
        GetPage(name: '/newPassword', page: () => NewPassword_Screen()),
        GetPage(name: '/upload', page: () => UploadFile_Screen()),
        GetPage(name: '/home_user', page: () => HomeUser_Screen()),
        GetPage(name: '/OTP', page: () => OTP_Screen(nextRoute: '',)),

      ],
    );
  }
}
