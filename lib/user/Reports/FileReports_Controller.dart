import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../../SharedPreferences/shared_preferences_service.dart';

class DownloadFileReportController extends GetxController {
  var isLoading = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<void> downloadReportForFile(int fileId, int folderId) async {
    isLoading.value = true;
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

    var request = http.Request(
        'GET', Uri.parse('http://195.88.87.77:8888/api/v1/reports/file?fileId=$fileId&folderId=$folderId')
    );
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final Uint8List bytes = await response.stream.toBytes();

        String filename = response.headers['content-disposition'] ?? 'report.csv';

        if (filename.contains('filename=')) {
          filename = filename.split('filename=')[1]?.replaceAll('"', '') ?? 'report.csv';
        } else {
          filename = 'report.csv';
        }

        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = filename;

        anchor.click();

        Get.snackbar('Success', 'Report downloaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to download report: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error while downloading report: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
