import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../SharedPreferences/shared_preferences_service.dart';
import '../../../UploadFile/UploadFile_Model.dart';


class MyBookedFilesController extends GetxController {
  var myBookedFiles = <FileModel>[].obs;
  var filesOfFolder = <FileModel>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();


  @override
  void onInit() {
    fetchFilesByUser();
    super.onInit();
  }

  Future<void> fetchFilesByUser() async {
    isLoading(true);
    try {
      String? token =await _sharedPreferencesService.getToken();
      int? userId = await _sharedPreferencesService.getUserId() ;
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
        Uri.parse('http://195.88.87.77:8888/api/v1/files/booked/users/$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());
        myBookedFiles.value =
            jsonResponse.map((file) => FileModel.fromJson(file)).toList();
      } else {
        Get.snackbar('Error',
            'Failed to load groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFilesByFolder() async {
    isLoading(true);
    try {
      String? token =await _sharedPreferencesService.getToken();

      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/files/folder/${2}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());
        filesOfFolder.value =
            jsonResponse.map((file) => FileModel.fromJson(file)).toList();
      } else {
        Get.snackbar('Error',
            'Failed to load groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }


  Future<void> fileCheckIn(int fileId) async {
    String? token =await _sharedPreferencesService.getToken();
    int? userId = await _sharedPreferencesService.getUserId() ;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer {$token}'
    };
    var request = http.Request(
        'POST', Uri.parse('http://195.88.87.77:8888/api/v1/files/check-in'));
    request.body = json.encode({"userId":userId, "fileId": fileId});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

}
