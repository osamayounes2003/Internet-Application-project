import 'dart:convert';

import 'package:file_manager_internet_applications_project/Loclaization/en.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Admin/FileTracing/file_tracing_model.dart';
import '../../Admin/FileTracing/FileTracing_Screen.dart';
import '../../SharedPreferences/shared_preferences_service.dart';
import 'FileTracingRequest_Model.dart';

class FileTracingController extends GetxController {
  var fileTracingList = <FileTracingModel>[].obs;
  var selectedUserId = 0.obs;
  var selectedType = "CHECK_IN".obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<void> sendFileTracingRequest(int fileId) async {
    String? token = await _sharedPreferencesService.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    // استبدال القيم null بسلسلة فارغة
    final String userId = selectedUserId.value == 0 ? '' : selectedUserId.value.toString();
    final String type = selectedType.value ?? '';
    final String startDate = this.startDate.value != null
        ? (this.startDate.value!.toUtc().toIso8601String() == this.endDate.value?.toUtc().toIso8601String()
        ? ''
        : this.startDate.value!.toUtc().toIso8601String())
        : '';

    final String endDate = this.endDate.value != null
        ? (this.startDate.value!.toUtc().toIso8601String() == this.endDate.value?.toUtc().toIso8601String()
        ? ''
        : this.endDate.value!.toUtc().toIso8601String())
        : '';


    print("**");
    print(fileId);
    print("**");
    print(type);
    print("**");
    print(userId);
    print("**");
    print(startDate);
    print("**");
    print(endDate);

    final uri = Uri.parse(
        'http://195.88.87.77:8888/api/v1/file-tracing'
            '?fileId=$fileId'
            '&userId=$userId'
            '&type=$type'
            '&start=$startDate'
            '&end=$endDate'
    );

    var headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.get(uri, headers: headers);
      print("File tracing response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = List.from(json.decode(response.body));
        fileTracingList.value = responseData.map((data) => FileTracingModel.fromJson(data)).toList();
        // Navigate to FileTracingScreen
        Get.to(() => FileTracingScreen(), arguments: fileTracingList.value);

        Get.snackbar('Success', 'Request sent successfully');
        print(response.body);
      } else {
        print(response.reasonPhrase);
        Get.snackbar('Error', 'Failed to send request: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
