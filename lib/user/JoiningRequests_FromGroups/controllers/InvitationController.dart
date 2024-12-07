import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:file_manager_internet_applications_project/user/JoiningRequests_FromGroups/models/InvitiationModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvitationController extends GetxController {
  var invitations = <Invitation>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchInvitations();
    super.onInit();
  }
  Future<void> fetchInvitations() async {
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

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/joins/my-invites'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        invitations.value = data.map((item) => Invitation.fromJson(item)).toList();
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptInvitation(int invitationId,int folderId) async {
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
      var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/joins/accept/$invitationId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
print(invitationId);
print(folderId);
print(token);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        fetchInvitations();

        // FirebaseMessaging messaging = FirebaseMessaging.instance;
        // String topic = "group$folderId";
        // await messaging.subscribeToTopic(topic);
        // print("Subscribed to Firebase Topic: $topic");

        Get.snackbar("success", "Successfully accepted the invitation",colorText:color_.white);
      } else {
        print(response.statusCode);
        print('Error: ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to accept the invitation',colorText:color_.white);
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', 'An error occurred while accepting the invitation',colorText:color_.white);
    }
  }

  Future<void> rejectInvitation(int invitationId) async {
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
      var request = http.Request('DELETE', Uri.parse('http://195.88.87.77:8888/api/v1/joins/reject/$invitationId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 204) {
        fetchInvitations();
        Get.snackbar("Success", "Successfully rejected the invitation",colorText:color_.white);
      } else {
        print('Error: ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to reject the invitation',colorText:color_.white );
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', 'An error occurred while rejecting the invitation',colorText:color_.white);
    }
  }
}


