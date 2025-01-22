import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../SharedPreferences/shared_preferences_service.dart';

class AllfilesController extends GetxController {
  var isLoading = false.obs;
  var files = [].obs;
  var totalPages = 1.obs;
  var currentPage = 0.obs;

  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    super.onInit();
    fetchFiles(currentPage.value); // تحميل الصفحة الأولى عند التهيئة
  }

  Future<void> fetchFiles(int pageNumber) async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/files?pageNumber=$pageNumber&pageSize=1'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        files.value = data['content'];
        totalPages.value = data['totalPages'];
        currentPage.value = pageNumber;
      } else {
        Get.snackbar('Error', 'Failed to fetch files');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteFile(int fileId) async {
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
        Uri.parse('http://195.88.87.77:8888/api/v1/files/$fileId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        files.removeWhere((file) => file['id'] == fileId);
        Get.snackbar('Success', 'File deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete file: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
