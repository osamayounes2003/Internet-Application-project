import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../SharedPreferences/shared_preferences_service.dart';
import '../../../UploadFile/UploadFile_Model.dart';

class BookedFilesByFolderController extends GetxController {
  var filesOfFolder = <FileModel>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchFilesByFolder();
  }

  Future<void> fetchFilesByFolder() async {
    String? token = await _sharedPreferencesService.getToken();

    isLoading(true);
    try {
      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/files/folders/${7}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());
        filesOfFolder.value =
            jsonResponse.map((file) => FileModel.fromJson(file)).toList();
      } else {
        Get.snackbar('Error',
            'Failed to load groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }
}
