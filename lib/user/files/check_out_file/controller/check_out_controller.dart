import 'dart:developer';

import 'package:file_manager_internet_applications_project/Routes/app_routes.dart';
import 'package:file_manager_internet_applications_project/user/files/my_booked_files/controller/booked_files_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../SharedPreferences/shared_preferences_service.dart';

class CheckoutController extends GetxController {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  RxList<int> selectedFileBytes = RxList<int>();
  var responseMessage = ''.obs;
  var selectedFilePath = ''.obs;
  var selectedFileName = ''.obs;
  var isUploading = false.obs;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedFileBytes.value = result.files.single.bytes ?? [];
      selectedFileName.value = result.files.single.name;
    } else {
      selectedFileName.value = '';
      Get.snackbar('Error', 'No file selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> showCheckoutDialog(int fileId) async {
    await Get.defaultDialog(
      title: "Checkout Options",
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await checkout('', fileId);
            },
            child: const Text("Check Out without Upload File"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await selectFile();
              checkout(selectedFilePath.value, fileId);
            },
            child: const Text("Check Out with Upload File"),
          ),
        ],
      ),
    );
  }

  Future<void> checkout(String filesPath, int id) async {
    final String? token = await _sharedPreferencesService.getToken();

    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse("http://195.88.87.77:8888/api/v1/files/check-out/$id"),
    );
    request.headers.addAll(headers);
    if (filesPath.isNotEmpty) {
      // request.files.add(await http.MultipartFile.fromPath("file", filesPath));
      request.files.add(http.MultipartFile.fromBytes("file", selectedFileBytes,
          filename: selectedFileName.value));
    }
    http.StreamedResponse response = await request.send();
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offNamed(AppRoutes.homeUser);
      log("Update file successfully");
    } else {
      log("Error: ${response.reasonPhrase}");
    }
  }
}
