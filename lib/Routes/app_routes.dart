import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Admin/HomeAdmin/HomeAdmin_Screen.dart';
import '../Auth/LogIN/LogIn_Screen.dart';
import '../Auth/OTP/OTP_Screen.dart';
import '../Auth/ResetPassword/NewPassword_Screen.dart';
import '../Auth/ResetPassword/ResetPassword_Screen.dart';
import '../Auth/SignUp/SignUp_Screen.dart';
import '../CommonInterfaces/Profile/Profile.dart';
import '../user/CreateGroup/screens/CreateGroup_screen.dart';
import '../user/Group/screens/Group_screen.dart';
import '../user/Groups/screens/Groups_screen.dart';
import '../user/HomeUser/HomeUser_Screen.dart';
import '../user/InviteUserToGroup/screens/InviteUser_screen.dart';
import '../user/JoiningRequests_FromGroups/screens/JoiningRequests_screen.dart';
import '../user/JoiningRequests_ToMyGroups/screens/JoiningRequestUsers_screen.dart';
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
  static const String InviteUser = '/InviteUser';
  static const String JoiningRequests = '/JoiningRequests';
  static const String JoiningRequests_toMyGroups = '/JoiningRequests_toMyGroups';

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
    GetPage(name: homeAdmin, page: () => HomeAdmin_Screen()),
    GetPage(name: InviteUser, page: () => InviteUser_screen()),
    GetPage(name: JoiningRequests, page: () => JoiningRequests_screen()),
    GetPage(name: JoiningRequests_toMyGroups, page: () => JoiningRequestUsers_screen()),

  ];
}
