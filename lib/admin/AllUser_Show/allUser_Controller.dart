import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SharedPreferences/shared_preferences_service.dart';
import '../../user/Groups/models/Groups_Model.dart';

class AllUsersController extends GetxController {
  var users = <User>[].obs;
  var filteredUsers = <User>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    ever(searchQuery, (_) => filterUsers());
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    const String url = 'http://195.88.87.77:8888/api/v1/users';
    String? token = await _sharedPreferencesService.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      isLoading(false);
      return;
    }
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        users.value = responseData.map((data) => User.fromJson(data)).toList();
        filteredUsers.assignAll(users);
      } else {
        Get.snackbar("Error", "Failed to load users: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterUsers() {
    if (searchQuery.value.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(
        users.where((user) =>
        user.fullname.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            user.email.toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList(),
      );
    }
  }


  Future<void> deleteUser(int userId) async {
    try {
      isLoading(true);
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.delete(
        Uri.parse('http://195.88.87.77:8888/api/v1/users/$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        users.removeWhere((user) => user.id == userId);
        filteredUsers.removeWhere((user) => user.id == userId);
        Get.snackbar('Success', 'User deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete user: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

}
