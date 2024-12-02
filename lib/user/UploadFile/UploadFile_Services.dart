import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SharedPreferences/shared_preferences_service.dart';
import 'UploadFile_Model.dart';

class FileUploadService {
  final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  Future<FileModel?> uploadFileBytes(List<int> fileBytes, String fileName, int groupId) async {
    String? token = await sharedPreferencesService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }


    int? userId = await sharedPreferencesService.getUserId();
    if (userId == null) {
      throw Exception('No userId found');
    }

    print(userId+groupId);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest('POST', Uri.parse('http://195.88.87.77:8888/api/v1/files'));
    request.fields['folderId'] = groupId.toString();
    request.fields['userId'] = userId.toString();
    request.files.add(http.MultipartFile.fromBytes('file', fileBytes, filename: fileName));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = json.decode(responseBody);
      return FileModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to upload file: ${response.reasonPhrase}');
    }
  }
}
