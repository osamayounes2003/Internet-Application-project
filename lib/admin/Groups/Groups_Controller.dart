import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'package:file_manager_internet_applications_project/admin/Groups/Groups_Model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupsController extends GetxController {
  var groups = <Groups>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchGroups();
    super.onInit();
  }

  Future<void> fetchGroups() async {
    isLoading(true);
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


      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/folders'),
        headers: headers,
      );
      print(".........................................");
      print(token);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        groups.value = jsonResponse.map((group) => Groups.fromJson(group)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }
}




// import 'dart:convert';
// import 'package:file_manager_internet_applications_project/color_.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../SharedPreferences/shared_preferences_service.dart';
// import 'groups_model.dart';
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
//     print("....................................");
//     print("Token: $token");
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
//         print(response.statusCode);
//         Get.snackbar('Error', 'Failed to load groups: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load groups: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }
//


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
