import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../SharedPreferences/shared_preferences_service.dart';
import '../model/file_model.dart';

class MyBookedFilesController extends GetxController {
  var myBookedFiles = <Content>[].obs; // Change to List<Content>
  var filesOfFolder = <FileModel>[].obs; // Assuming this will also use FileModel later
  var isLoading = true.obs;
  var totalPages = 1.obs;
  var currentPage = 0.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchBookedFiles(currentPage.value);
    super.onInit();
  }

  Future<void> fetchBookedFiles(int pageNumber) async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();
      int? userId = await _sharedPreferencesService.getUserId();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/files/booked/users/$userId?pageNumber=$pageNumber&pageSize=10'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Ensure that 'content' is a list and parse it
        if (data['content'] != null && data['content'] is List) {
          myBookedFiles.value = (data['content'] as List)
              .map((item) => Content.fromJson(item))
              .toList();
          print('Fetched files: ${myBookedFiles.toString()}');
        } else {
          print('No content found in response');
        }

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

  Future<void> fileCheckIn(int fileId) async {
    String? token = await _sharedPreferencesService.getToken();
    int? userId = await _sharedPreferencesService.getUserId();

    if (token == null || userId == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    var request = http.Request(
      'POST',
      Uri.parse('http://195.88.87.77:8888/api/v1/files/check-in'),
    );

    request.body = json.encode({"userId": userId, "fileId": fileId});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(await response.stream.bytesToString());
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurred while checking in: $e');
    }
  }
}