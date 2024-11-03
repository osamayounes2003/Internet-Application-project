import 'dart:convert';
import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InviteUserController extends GetxController {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  var isLoading = true.obs;

  Future<void> inviteUser(int userId, int folderId) async {
    isLoading.value = true;
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }

      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      print("Token: $token");

      var request = http.Request('POST', Uri.parse('http://195.88.87.77:8888/api/v1/joins/invite-user'));
      request.body = json.encode({
        "folderId": folderId,
        "userId": userId
      });
      request.headers.addAll(headers);
      request.headers['Content-Type'] = 'application/json';


      http.StreamedResponse response = await request.send();

      String responseBody = await response.stream.bytesToString();
      if (response.statusCode == 201) {
        print(responseBody);
        Get.snackbar("Success", "User invited successfully");
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: $responseBody');
        Get.snackbar("Error", "Invitation failed: ${response.reasonPhrase}\nResponse: $responseBody");
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "An unexpected error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
