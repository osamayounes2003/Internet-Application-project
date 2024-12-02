import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../SharedPreferences/shared_preferences_service.dart';

class RemoveUserController extends GetxController {
  var isLoading = false.obs;
  final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  Future<void> removeUser(int groupId, {bool isme = false, int? userId,}) async {
    isLoading.value = true;

    String? token = await sharedPreferencesService.getToken();
    if (token == null) {
      Get.snackbar("Error", "No token found. Please log in again.");
      return;
    }

    var headers = {
      'Authorization': 'Bearer $token',
    };

    print('group id :');
    print(groupId);
    print("user id:");
    print(userId);

    bool leave = isme;

    if (isme) {
      userId = await sharedPreferencesService.getUserId() ?? userId;
      print("UserId from SharedPreferences: $userId");
    }

    var request = http.Request(
      'DELETE',
      Uri.parse('http://195.88.87.77:8888/api/v1/users/leave?folderId=$groupId&leave=$leave&userId=$userId'),
    );

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 204) {
        Get.snackbar("Success", "User has been removed from the group.");
        Get.offAllNamed('/Group');
      } else {
        Get.snackbar("Error", "Failed to remove the user. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


