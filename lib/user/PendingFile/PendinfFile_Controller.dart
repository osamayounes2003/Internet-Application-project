// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../SharedPreferences/shared_preferences_service.dart';
// import '../Groups/controllers/Groups_Controller.dart';
// import 'PendingFile_Model.dart';
//
// class PendingFileController extends GetxController {
//   var files = <PendingFileModel>[].obs;
//   var isLoading = false.obs;
//   final SharedPreferencesService _sharedPreferencesService =
//       SharedPreferencesService();
//
//   late String apiUrl;
//
//   @override
//   void onInit() {
//     super.onInit();
//     final groupId = Get.arguments?['groupId'];
//     if (groupId == null) {
//       Get.snackbar('Error', 'Group ID is not provided');
//       return;
//     }
//     print(groupId);
//     apiUrl = 'http://195.88.87.77:8888/api/v1/files/pending/$groupId';
//     fetchFiles();
//   }
//
//   Future<void> fetchFiles() async {
//     try {
//       String? token = await _sharedPreferencesService.getToken();
//
//       if (token == null) {
//         Get.snackbar('Error', 'User is not authenticated');
//         isLoading(false);
//         return;
//       }
//
//       isLoading.value = true;
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       print("pending file ${response.statusCode}");
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         files.value =
//             data.map((json) => PendingFileModel.fromJson(json)).toList();
//       } else {
//         print(response.reasonPhrase);
//         Get.snackbar(
//             "Error", "Failed to fetch files: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print(e);
//       Get.snackbar("Error", "An error occurred: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> approveFile(int fileId) async {
//     try {
//       String? token = await _sharedPreferencesService.getToken();
//
//       if (token == null) {
//         Get.snackbar('Error', 'User is not authenticated');
//         return;
//       }
//
//       final response = await http.post(
//         Uri.parse('http://195.88.87.77:8888/api/v1/files/approve/$fileId'),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//
//       if (response.statusCode == 200 || response.statusCode==204) {
//         fetchFiles();
//         Get.snackbar("Success", "File approved successfully");
//       } else {
//         Get.snackbar("Error", "Failed to approve file");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
//
//   Future<void> rejectFile(int fileId) async {
//     try {
//       String? token = await _sharedPreferencesService.getToken();
//
//       if (token == null) {
//         Get.snackbar('Error', 'User is not authenticated');
//         return;
//       }
//
//       final response = await http.post(
//         Uri.parse('http://195.88.87.77:8888/api/v1/files/reject/$fileId'),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//
//       if (response.statusCode == 200 || response.statusCode==204) {
//         fetchFiles();
//         Get.snackbar("Success", "File rejected successfully");
//       } else {
//         Get.snackbar("Error", "Failed to reject file");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
//
//   Future<void> updateFileStatus(int fileId, bool accept) async {
//     try {
//       String? token = await _sharedPreferencesService.getToken();
//
//       if (token == null) {
//         Get.snackbar('Error', 'User is not authenticated');
//         return;
//       }
//
//       final url = Uri.parse(
//           'http://195.88.87.77:8888/api/v1/files/accept?accept=$accept&fileId=$fileId');
//
//       final response = await http.put(
//         url,
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       print("accept/reject file ${response.statusCode}");
//       if (response.statusCode == 204 || response.statusCode==200) {
//         fetchFiles();
//         final GroupsController groupsController = Get.find<GroupsController>();
//         await groupsController.fetchGroups();
//         Get.snackbar(
//           "Success",
//           accept ? "File approved successfully" : "File rejected successfully",
//         );
//       } else {
//         Get.snackbar("Error", "Failed to update file status");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Admin/AllFiles_show/FilePage_Model.dart';
import '../../SharedPreferences/shared_preferences_service.dart';

class PendingFileController extends GetxController {
  var files = <Content>[].obs;
  var isLoading = false.obs;
  var totalPages = 1.obs;
  var currentPage = 0.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  late String apiUrl;

  @override
  void onInit() {
    super.onInit();
    final groupId = Get.arguments?['groupId'];
    print('Received groupId: $groupId');
    if (groupId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', 'Group ID is not provided');
      });
      return;
    }
    apiUrl = 'http://195.88.87.77:8888/api/v1/files/pending/$groupId';
    fetchFiles(currentPage.value);
  }

  Future<void> fetchFiles(int pageNumber) async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }

      var headers = {'Authorization': 'Bearer $token'};

      var response = await http.get(
        Uri.parse('$apiUrl?pageNumber=$pageNumber&pageSize=10'),
        headers: headers,
      );

      print("pending file ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        ApiResponse apiResponse = ApiResponse.fromJson(data);
        files.value = apiResponse.content;
        totalPages.value = apiResponse.totalPages;
        currentPage.value = pageNumber;
      } else {
        print(response.reasonPhrase);
        Get.snackbar('Error', 'Failed to fetch files: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateFileStatus(int fileId, bool accept) async {
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var url = Uri.parse(
          'http://195.88.87.77:8888/api/v1/files/accept?accept=$accept&fileId=$fileId');
      var headers = {'Authorization': 'Bearer $token'};

      var response = await http.put(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        fetchFiles(currentPage.value);
        Get.snackbar(
          'Success',
          accept ? 'File approved successfully' : 'File rejected successfully',
        );
      } else {
        Get.snackbar('Error', 'Failed to update file status');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
