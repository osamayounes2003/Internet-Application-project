import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../SharedPreferences/shared_preferences_service.dart';
import 'AddFiles_Model.dart';

class AddFilesController extends GetxController {
  var uploadedFiles = <FileModel>[].obs;
  var isLoading = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  void addUploadedFile(FileModel file) {
    uploadedFiles.add(file);
  }

  Future<void> uploadFiles(int groupId) async {
    String? token = await _sharedPreferencesService.getToken();
    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    if (uploadedFiles.isEmpty) {
      Get.snackbar('Error', 'No files to upload.');
      return;
    }

    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    for (var file in uploadedFiles) {
      var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/files'));
      request.body = json.encode({
        "folderId": groupId.toString(),
        "fileId": file.id.toString(),
      });
      request.headers.addAll(headers);

      try {
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          Get.snackbar('Success', 'File uploaded successfully: ${file.name}');
        } else {
          Get.snackbar('Error', response.reasonPhrase!);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload files: $e');
      }
    }

    isLoading.value = false;
  }
}



// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'AddFiles_Model.dart';
//
// class AddFilesController extends GetxController {
//   var uploadedFiles = <FileModel>[].obs;
//   var isLoading = false.obs;
//
//   void addUploadedFile(FileModel file) {
//     uploadedFiles.add(file);
//   }
//
//   Future<void> uploadFiles(int groupId) async { // Accept groupId as a parameter
//     if (uploadedFiles.isEmpty) {
//       Get.snackbar('Error', 'No files to upload.');
//       return;
//     }
//
//     isLoading.value = true;
//
//     var headers = {
//       'Content-Type': 'application/json',
//       'Accept': '*/*',
//       'Authorization': 'Bearer YOUR_TOKEN_HERE',
//     };
//
//     for (var file in uploadedFiles) {
//       var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/files'));
//       request.body = json.encode({
//         "folderId": groupId.toString(), // Use the specific group ID
//         "fileId": file.id.toString(),
//       });
//       request.headers.addAll(headers);
//
//       try {
//         http.StreamedResponse response = await request.send();
//
//         if (response.statusCode == 200) {
//           print(await response.stream.bytesToString());
//         } else {
//           Get.snackbar('Error', response.reasonPhrase!);
//         }
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to upload files: $e');
//       }
//     }
//
//     isLoading.value = false;
//   }
// }




// Future<void> uploadFiles(String folderId) async {
  //   if (uploadedFiles.isEmpty) {
  //     Get.snackbar('Error', 'No files to upload.');
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': '*/*',
  //     'Authorization': 'Bearer YOUR_TOKEN_HERE',
  //   };
  //
  //   for (var file in uploadedFiles) {
  //     var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/files'));
  //     request.body = json.encode({
  //       "folderId": folderId,
  //       "fileId": file.id.toString(),
  //     });
  //     request.headers.addAll(headers);
  //
  //     try {
  //       http.StreamedResponse response = await request.send();
  //
  //       if (response.statusCode == 200) {
  //         print(await response.stream.bytesToString());
  //       } else {
  //         Get.snackbar('Error', response.reasonPhrase!);
  //       }
  //     } catch (e) {
  //       Get.snackbar('Error', 'Failed to upload files: $e');
  //     }
  //   }
  //
  //   isLoading.value = false;
  // }

  // Future<void> uploadFiles(String folderId) async {
  //   if (uploadedFiles.isEmpty) {
  //     Get.snackbar('Error', 'No files to upload.');
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': '*/*',
  //     'Authorization': 'Bearer YOUR_TOKEN_HERE', // replace with your token
  //   };
  //
  //   for (var file in uploadedFiles) {
  //     var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/files'));
  //     request.body = json.encode({
  //       "folderId": folderId,
  //       "fileId": file.id.toString(), // Assuming the file has an ID
  //     });
  //     request.headers.addAll(headers);
  //
  //     try {
  //       http.StreamedResponse response = await request.send();
  //
  //       if (response.statusCode == 200) {
  //         print(await response.stream.bytesToString());
  //       } else {
  //         Get.snackbar('Error', response.reasonPhrase!);
  //       }
  //     } catch (e) {
  //       Get.snackbar('Error', 'Failed to upload files: $e');
  //     }
  //   }
  //
  //   isLoading.value = false;
  // }

