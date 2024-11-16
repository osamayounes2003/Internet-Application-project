import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:file_picker/file_picker.dart';

class CheckoutController extends GetxController {
  var filePath = ''.obs;
  var id = 1;
  var withFile = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      filePath.value = file.name;
      withFile.value = true;
    } else {
      Get.snackbar('Info', 'User canceled the picker.');
    }
  }

  void checkout(
      String filesPath,
      int id,
      bool withFile,
      ) async {

    String? token =await _sharedPreferencesService.getToken();

    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse("195.88.87.77:8888/api/v1/files/check-out/$id"),
    );

    request.headers.addAll(headers);

    if (withFile) {
      request.files.add(await http.MultipartFile.fromPath("file", filesPath));
    }

    http.StreamedResponse response = await request.send();

    log(response.statusCode.toString());
    if (response.statusCode.toString() == '200' ||
        response.statusCode.toString() == '201') {
      log("Update file successfully");
    } else {
      log("error");
    }
  }
}
