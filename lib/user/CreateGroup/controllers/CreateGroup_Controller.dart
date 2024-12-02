import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../SharedPreferences/shared_preferences_service.dart';
import '../../Groups/controllers/Groups_Controller.dart';
import '../models/CreateGroup_Model.dart';

class CreateGroupController extends GetxController {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  final Rx<CreateGroupModel> group = CreateGroupModel().obs;
  var groupName = ''.obs;

  void setGroupName(String name) {
    groupName.value = name;
  }

  Future<bool> createGroup(String groupName) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null || token.isEmpty) {
        Get.snackbar('Error', 'User is not authenticated');
        return false;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var body = json.encode({"name": groupName});
      var request = http.Request(
        'POST',
        Uri.parse('http://195.88.87.77:8888/api/v1/folders'),
      );
      request.body = body;
      request.headers.addAll(headers);

      http.StreamedResponse creationResponse = await request.send();

      if (creationResponse.statusCode == 201) {
        try {
          var responseData = await creationResponse.stream.bytesToString();
          var jsonResponse = json.decode(responseData);
          group.value = CreateGroupModel.fromJson(jsonResponse);
          Get.reload<GroupsController>();
          Get.offAllNamed('/Group');
          Get.snackbar('Success', 'Group created successfully', colorText: color_.white);
          return true;
        } catch (e) {
          Get.snackbar('Error', 'Failed to parse creation response: $e',
              colorText: color_.white);
          print("Parsing creation response error: $e");
          return false;
        }
      } else {
        var errorMessage = await creationResponse.stream.bytesToString();
        print("Creation error: ${creationResponse.reasonPhrase}, Body: $errorMessage");
        Get.snackbar('Error', 'Failed to create group: ${creationResponse.reasonPhrase ?? 'Unknown error'}',
            colorText: color_.white);
        return false;
      }
    } catch (e) {
      print("Unexpected error: $e");
      Get.snackbar('Error', 'Failed to create group: $e', colorText: color_.white);
      return false;
    }
  }
}
