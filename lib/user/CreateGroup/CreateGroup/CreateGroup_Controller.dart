import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../SharedPreferences/shared_preferences_service.dart';
import 'CreateGroup_Model.dart';

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

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return false;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/folders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> groups = json.decode(response.body);
        bool nameExists = groups.any((group) => group['name'] == groupName);

        if (nameExists) {
          Get.snackbar('Error', 'Group name already exists. Please choose a different name.');
          return false;
        }
      } else {
        Get.snackbar('Error', 'Failed to check existing groups');
        return false;
      }

      var body = json.encode({"name": groupName});
      var request = http.Request('POST', Uri.parse('http://195.88.87.77:8888/api/v1/folders'));
      request.body = body;
      request.headers.addAll(headers);

      http.StreamedResponse creationResponse = await request.send();

      if (creationResponse.statusCode == 201) {
        var responseData = await creationResponse.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        group.value = CreateGroupModel.fromJson(jsonResponse);
        Get.snackbar('Success', 'Group created successfully');
        return true;
      } else {
        Get.snackbar('Error', creationResponse.reasonPhrase ?? 'Unknown error');
        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to create group: $e');
      return false;
    }
  }
}
