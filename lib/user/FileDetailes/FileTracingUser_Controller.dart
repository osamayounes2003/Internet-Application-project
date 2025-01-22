import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Admin/FileTracing/file_tracing_model.dart';
import '../../SharedPreferences/shared_preferences_service.dart';
import 'Backup_Model.dart'; // قم بإنشاء هذا النموذج للنسخ الاحتياطي

class FileTracingUserController extends GetxController {
  var fileTracingList = <FileTracingModel>[].obs;
  var backupList = <BackupModel>[].obs; // قائمة النسخ الاحتياطي
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    super.onInit();
  }

  // دالة جلب بيانات التتبع
  Future<void> fetchFileTracing(int fileID) async {
    String? token = await _sharedPreferencesService.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    final response = await http.get(
      Uri.parse('http://195.88.87.77:8888/api/v1/files/tracing/$fileID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("file tracing: ${response.statusCode}");
    print(fileID);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      fileTracingList.value = data.map((item) => FileTracingModel.fromJson(item)).toList();
      print(fileTracingList.value);
    } else {
      print("Failed to load file tracings");
    }
    isLoading.value = false;
  }

  // دالة جلب بيانات النسخ الاحتياطي
  Future<void> fetchBackupData(int fileID) async {
    String? token = await _sharedPreferencesService.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    final response = await http.get(
      Uri.parse('http://195.88.87.77:8888/api/v1/backups?fileId=$fileID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("backup data: ${response.statusCode}");
    print(fileID);

    print('backup ${response.statusCode}');
    print(fileID);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      backupList.value = data.map((item) => BackupModel.fromJson(item)).toList();
      print(backupList.value);
    } else {
      print("Failed to load backup data");
    }
    isLoading.value = false;
  }
}
