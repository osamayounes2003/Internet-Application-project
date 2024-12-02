import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../SharedPreferences/shared_preferences_service.dart';

class GroupSettingsController extends GetxController {
  var groupName = ''.obs;
  var isPrivate = false.obs;
  var disableAddFile = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();


  final int groupId;
  final List<String> settings;
  final String name;


  GroupSettingsController({required this.groupId, required this.settings ,required this.name});

  @override
  void onInit() {
    super.onInit();
    isPrivate.value = settings.contains("PRIVATE_FOLDER");
    disableAddFile.value = settings.contains("DISABLE_ADD_FILE");
    groupName.value=name;

  }

  Future<void> updateGroupSettings() async {
    String? token = await _sharedPreferencesService.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/$groupId'));

    request.body = json.encode({
      "name": groupName.value,
      "privateFolder": isPrivate.value,
      "disableAddFile": disableAddFile.value,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        Get.snackbar("Success", "Group settings updated successfully");
      } else {
        print(response.reasonPhrase);
        Get.snackbar("Error", "Failed to update group settings");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
