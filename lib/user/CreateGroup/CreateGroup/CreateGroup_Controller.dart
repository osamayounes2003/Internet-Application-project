import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../SharedPreferences/shared_preferences_service.dart';
import 'CreateGroup_Model.dart';

class CreateGroupController extends GetxController {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  final Rx<CreateGroupModel> group = CreateGroupModel().obs;
  var groupName = ''.obs;
  var uploadedFiles = <PlatformFile>[].obs;

  void setGroupName(String name) {
    groupName.value = name;
  }

  void addFiles(List<PlatformFile> files) {
    uploadedFiles.addAll(files);
  }

  Future<bool> createGroup(String groupName) async {
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var body = json.encode({
        "name": groupName,
      });

      var request = http.Request('POST', Uri.parse('http://195.88.87.77:8888/api/v1/folders'));
      request.body = body;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        group.value = CreateGroupModel.fromJson(jsonResponse);

        Get.snackbar('Success', 'Group created successfully');

      } else {
        Get.snackbar('Error', response.reasonPhrase ?? 'Unknown error');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to create group: $e');
    }
    return true;
  }

  Future<void> uploadFilesToGroup() async {
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
      };

      for (var file in uploadedFiles) {
        var fileRequest = http.MultipartRequest('POST', Uri.parse('http://195.88.87.77:8888/api/v1/files/upload'));
        fileRequest.headers.addAll(headers);

        fileRequest.files.add(await http.MultipartFile.fromPath(
          'file',
          file.path!,
          filename: file.name,
        ));

        http.StreamedResponse fileResponse = await fileRequest.send();
        String fileResponseBody = await fileResponse.stream.bytesToString();

        if (fileResponse.statusCode == 201) {
          var jsonResponse = json.decode(fileResponseBody);
          int fileId = jsonResponse['id'];

          var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/files'));
          request.headers.addAll(headers);
          request.body = json.encode({
            "folderId": group.value.id,
            "fileId": fileId,
          });

          http.StreamedResponse response = await request.send();
          String responseBody = await response.stream.bytesToString();

          if (response.statusCode == 201) {
            print('File associated with group successfully: ${file.name}');
          }if (fileResponse.statusCode == 403) {
            print('Access forbidden. Check your permissions.');
            Get.snackbar('Error', 'Access forbidden. Check your permissions.');
          }
        else {
            print('Error associating file with group: ${file.name}, Status code: ${response.statusCode}');
            print('Error response: $responseBody');
          }
        } else {
          print('Error uploading file: ${file.name}, Status code: ${fileResponse.statusCode}');
          print('Error response: $fileResponseBody');
        }
      }

      Get.snackbar('Success', 'Files uploaded and associated with group successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload files: $e');
    }
  }
}
