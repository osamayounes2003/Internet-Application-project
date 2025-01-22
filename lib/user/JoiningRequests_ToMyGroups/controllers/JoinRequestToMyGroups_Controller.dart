import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../SharedPreferences/shared_preferences_service.dart';
import '../../../color_.dart';
import '../models/JoinRequestsToMyGroups_Model.dart';

class JoinRequestToMyGroupsController extends GetxController {
  var joinRequests = <JoinRequestToMyGroups>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  Future<void> fetchJoinRequests(int folderId) async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var request = http.Request(
          'GET',
          Uri.parse(
              'http://195.88.87.77:8888/api/v1/joins/requests/$folderId'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        List jsonResponse = json.decode(responseBody);
        joinRequests.value = jsonResponse
            .map((data) => JoinRequestToMyGroups.fromJson(data))
            .toList();
      } else {
        print(
            ".................................................................${response.statusCode}");
        Get.snackbar(
            'Error', 'Failed to load join requests: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(
          ".................................................................${e}");

      Get.snackbar('Error', 'Failed to load join requests: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptInvitation(int invitationId, int folderId) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };
      var request = http.Request(
          'PUT',
          Uri.parse(
              'http://195.88.87.77:8888/api/v1/joins/accept?id=$invitationId'));
      print(invitationId);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        await fetchJoinRequests(folderId);
        Get.snackbar("Success", "Successfully accepted the invitation",
            colorText: color_.white);
      } else {
        print('Error: ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to accept the invitation',
            colorText: color_.white);
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', 'An error occurred while accepting the invitation',
          colorText: color_.white);
    }
  }

  Future<void> rejectInvitation(int invitationId, int folderId) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };
      var request = http.Request(
          'DELETE',
          Uri.parse(
              'http://195.88.87.77:8888/api/v1/joins/reject/$invitationId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(invitationId);
print("reject invetation : +${response.statusCode} ");
      if (response.statusCode == 204) {
        await fetchJoinRequests(folderId);
        Get.snackbar("Success", "Successfully rejected the invitation",
            colorText: color_.white);
      } else {
        print('Error: ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to reject the invitation',
            colorText: color_.white);
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', 'An error occurred while rejecting the invitation',
          colorText: color_.white);
    }
  }
}
