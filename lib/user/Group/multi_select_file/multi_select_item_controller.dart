import 'dart:convert';
import 'package:file_manager_internet_applications_project/Routes/app_routes.dart';
import 'package:file_manager_internet_applications_project/user/Groups/models/Groups_Model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../SharedPreferences/shared_preferences_service.dart';

class MultiSelectFileController extends GetxController {
  var files = <File>[].obs;
  var selectedIds = <int>[].obs;
  var isLoading = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
@override
  void onInit() {
    // TODO: implement onInit

  }
  void toggleSelection(int id) {
    final file = files.firstWhere((file) => file.id == id);
    file.isSelected = !file.isSelected;

    if (file.isSelected) {
      selectedIds.add(id);
    } else {
      selectedIds.remove(id);
    }

    files.refresh();
  }

  void selectAllFiles() {
    final allSelected = files.every((file) => file.isSelected);

    if (allSelected) {
      for (var file in files) {
        file.isSelected = false;
      }
      selectedIds.clear(); // Clear selected IDs
    } else {
      for (var file in files) {
        if (!file.isSelected) {
          file.isSelected = true;
          selectedIds.add(file.id); // Add ID to selected IDs
        }
      }
    }

    files.refresh();
  }

  Future<void> checkInMultiFile(List<int> selectedFilesIds) async {
    isLoading.value = true; // Set loading state to true
    String? token = await _sharedPreferencesService.getToken();
    int? userId = await _sharedPreferencesService.getUserId();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('http://195.88.87.77:8888/api/v1/files/check-in-all'));
    request.body = json.encode({
      "userId": userId,
      "fileIds": selectedFilesIds
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.Groups);
      print('Multi-selected files have been successfully checked in');

      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}