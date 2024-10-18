import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Auth/LogIN/LogIn_Screen.dart';
import '../Auth/OTP/OTP_Screen.dart';
import '../Auth/ResetPassword/NewPassword_Screen.dart';
import '../Auth/SignUp/SignUp_Screen.dart';
import '../user/HomeUser/HomeUser_Screen.dart';
import '../user/Profile/Profile.dart';
import '../user/UploadFile/UploadFile_Screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String newPassword = '/newPassword';
  static const String upload = '/upload';
  static const String homeUser = '/home_user';
  static const String otp = '/OTP';
  static const String profile = '/profile';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LogIn_Screen()),
    GetPage(name: signup, page: () => SignUp_Screen()),
    GetPage(name: newPassword, page: () => NewPassword_Screen()),
    GetPage(name: upload, page: () => UploadFile_Screen()),
    GetPage(name: homeUser, page: () => HomeUser_Screen()),
    GetPage(name: otp, page: () => OTP_Screen(nextRoute: '',)),
    GetPage(name: profile, page: () => Profile()),
  ];
}
