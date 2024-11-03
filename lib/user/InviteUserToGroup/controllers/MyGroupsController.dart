import 'dart:convert';
import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'package:get/get.dart';
import '../../../color_.dart';
import '../models/MyGroupsModel.dart';
import 'package:http/http.dart' as http;

class MyGroupsController extends GetxController {
  var groups = <MyGroupsModel>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchMyGroups();
    super.onInit();
  }

  Future<void> fetchMyGroups() async {
    try {
      isLoading(true);
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
        Uri.parse('http://195.88.87.77:8888/api/v1/folders/my-folders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        groups.value = jsonResponse.map((data) => MyGroupsModel.fromJson(data)).toList();
      } else {
        Get.snackbar('Error', response.reasonPhrase ?? 'Error occurred',colorText: color_.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch groups: $e',colorText: color_.white);
    } finally {
      isLoading(false);
    }
  }
}
