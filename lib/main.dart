import 'package:file_manager_internet_applications_project/Auth/LogIN/LogIn_Screen.dart';
import 'package:file_manager_internet_applications_project/Auth/OTP/OTP_Screen.dart';
import 'package:file_manager_internet_applications_project/Auth/ResetPassword/NewPassword_Screen.dart';
import 'package:file_manager_internet_applications_project/Auth/ResetPassword/ResetPassword_Screen.dart';
import 'package:file_manager_internet_applications_project/user/HomeUser/HomeUser_Screen.dart';
import 'package:file_manager_internet_applications_project/user/UploadFile/UploadFile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'Auth/SignUp/SignUp_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: HomeUser_Screen(),
      getPages: [
        GetPage(name: '/login', page: () =>  LogIn_Screen()),
        GetPage(name: '/OTP', page: () =>  OTP_Screen(nextRoute: '',)),
        GetPage(name: '/newPassword', page: () =>  NewPassword_Screen()),
        GetPage(name: '/upload', page: () =>  UploadFile_Screen()),


      ],
    );
  }
}
