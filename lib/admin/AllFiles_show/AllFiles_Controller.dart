import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../SharedPreferences/shared_preferences_service.dart';

class FileController extends GetxController {
  var isLoading = false.obs;
  var files = [].obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();


  @override
  void onInit() {
    super.onInit();
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }
      print(token);
      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/files'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        files.value = json.decode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to fetch files');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
