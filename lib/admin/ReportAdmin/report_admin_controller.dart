import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../../SharedPreferences/shared_preferences_service.dart';

class DownloadAdminReportController extends GetxController {
  var isLoading = false.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();


  String extractFileName(String? contentDisposition) {
    if (contentDisposition == null || !contentDisposition.contains('filename=')) {
      print('no header');
      return 'report.csv';
    }
    try {
      final filenamePart = contentDisposition.split('filename=')[1];
      final filename = filenamePart.split(';')[0].replaceAll('"', '').trim();
      return filename.isNotEmpty ? filename : 'report.csv';
    } catch (e) {
      return 'report.csv';
    }
  }

  Future<void> downloadAdminReport() async {
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

    var request = http.Request('GET', Uri.parse('http://195.88.87.77:8888/api/v1/reports/all'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final Uint8List bytes = await response.stream.toBytes();

        String? contentDisposition = response.headers['content-type'] ;
        print(contentDisposition);
        String filename = extractFileName(contentDisposition);

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
  }}
