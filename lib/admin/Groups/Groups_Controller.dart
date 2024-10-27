import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../SharedPreferences/shared_preferences_service.dart';
import 'groups_model.dart';

class GroupsController extends GetxController {
  var groups = <Groups>[].obs;
  var isLoading = true.obs;

  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    super.onInit();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    String? token = await _sharedPreferencesService.getToken();

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Authorization token not found');
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse('http://195.88.87.77:8888/api/v1/folders');

    try {
      isLoading(true);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        groups.value = jsonResponse.map((group) => Groups.fromJson(group)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load groups: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }
}



// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../Auth/SharedPreferences/shared_preferences_service.dart';
// import 'Groups_Model.dart';
//
// class GroupsController extends GetxController {
//   var groups = <Groups>[].obs;
//   var isLoading = true.obs;
//
//   final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchGroups();
//   }
//
//   Future<void> fetchGroups() async {
//     String? token = await _sharedPreferencesService.getToken();
//
//     if (token == null || token.isEmpty) {
//       Get.snackbar('Error', 'Authorization token not found');
//       return;
//     }
//
//     print('Token: $token');  // Log the token for debugging
//
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//
//     var url = Uri.parse('http://195.88.87.77:8888/api/v1/folders');
//
//     try {
//       isLoading(true);
//       final response = await http.get(url, headers: headers);
//
//       if (response.statusCode == 200) {
//         List<dynamic> jsonResponse = json.decode(response.body);
//         groups.value = jsonResponse.map((group) => Groups.fromJson(group)).toList();
//       } else {
//         print('Status Code: ${response.statusCode}');
//         Get.snackbar('Error', 'Failed to load groups: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       Get.snackbar('Error', 'Failed to load groups: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }
