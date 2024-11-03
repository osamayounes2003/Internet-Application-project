import 'dart:convert';
import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'package:file_manager_internet_applications_project/user/InviteUserToGroup/models/UsersModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  var users = <Users>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  String? currentUserEmail;

  @override
  void onInit() {
    super.onInit();
    fetchLoggedUser();
    fetchUsers();
  }

  Future<void> fetchLoggedUser() async {
    var userData = await _sharedPreferencesService.getUserData();
    currentUserEmail = userData?['email'];
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;

    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }

      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/users'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        users.value = data
            .map((json) => Users.fromJson(json))
            .where((user) => user.email != currentUserEmail)
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to load users');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users');
    } finally {
      isLoading.value = false;
    }
  }
}
