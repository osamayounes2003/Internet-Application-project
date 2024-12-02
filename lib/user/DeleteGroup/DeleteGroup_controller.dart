import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../SharedPreferences/shared_preferences_service.dart';

class DeleteGroupController extends GetxController {
  var isLoading = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();


  Future<void> deleteGroup(int groupId) async {
    isLoading.value = true;

    String? token = await _sharedPreferencesService.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      isLoading(false);
      return;
    }
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request(
      'DELETE',
      Uri.parse('http://195.88.87.77:8888/api/v1/folders/$groupId'),
    );
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode==201 || response.statusCode==204) {
        Get.snackbar('Success', 'Group deleted successfully');
        Get.offAllNamed('/Group');
      } else {
        Get.snackbar('Error', 'Failed to delete group: ${response.reasonPhrase}');
        print(response.reasonPhrase);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error while deleting group: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
