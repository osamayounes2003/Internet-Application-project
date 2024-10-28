import 'package:file_manager_internet_applications_project/admin/CreateGroup/AddMembers/AddMembers_screen.dart';
import 'package:file_manager_internet_applications_project/admin/CreateGroup/CreateGroup/CreateGroup_screen.dart';
import 'package:file_manager_internet_applications_project/admin/Groups/Groups_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Admin/HomeAdmin/HomeAdmin_Screen.dart';
import '../Auth/LogIN/LogIn_Screen.dart';
import '../Auth/OTP/OTP_Screen.dart';
import '../Auth/ResetPassword/NewPassword_Screen.dart';
import '../Auth/ResetPassword/ResetPassword_Screen.dart';
import '../Auth/SignUp/SignUp_Screen.dart';
import '../CommonInterfaces/Profile/Profile.dart';
import '../admin/Group/Group_screen.dart';
import '../user/HomeUser/HomeUser_Screen.dart';
import '../user/UploadFile/UploadFile_Screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String newPassword = '/newPassword';
  static const String upload = '/upload';
  static const String homeUser = '/home_user';
  static const String homeAdmin = '/home_admin';
  static const String otp = '/OTP';
  static const String profile = '/profile';
  static const String resetPasswordScreen = '/ResetPasswordScreen';
  static const String Groups = '/Groups';
  static const String Group = '/Group';
  static const String CreateGroup = '/CreateGroup';
  static const String AddMembers = '/AddMembers';


  static List<GetPage> routes = [
    GetPage(name: login, page: () => LogIn_Screen()),
    GetPage(name: signup, page: () => SignUp_Screen()),
    GetPage(name: newPassword, page: () => NewPassword_Screen(emailAddress: "")),
    GetPage(name: upload, page: () => UploadFile_Screen()),
    GetPage(name: homeUser, page: () => HomeUser_Screen()),
    GetPage(name: otp, page: () => OTP_Screen(nextRoute: '',emailAddress: " ",)),
    GetPage(name: profile, page: () => Profile()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: Groups, page: () => Groups_screen()),
    GetPage(name: Group, page: () => Group_screen()),
    GetPage(name: CreateGroup, page: () => CreateGroup_screen()),
    GetPage(name: AddMembers, page: () => AddMembers_screen()),
    GetPage(name: homeAdmin, page: () => HomeAdmin_Screen()),

  ];
}
