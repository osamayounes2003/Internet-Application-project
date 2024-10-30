import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import 'Groups_Model.dart';

class GroupsController extends GetxController {
  var groups = <Groups>[].obs;
  var ownGroups = <Groups>[].obs;
  var otherGroups = <Groups>[].obs;
  var joinedOtherGroups = <Groups>[].obs;
  var notJoinedOtherGroups = <Groups>[].obs;
  var currentGroupList = <Groups>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchGroups();
    fetchOwnGroups();
    fetchOtherGroups();
    super.onInit();
  }

  Future<void> fetchGroups() async {
    isLoading(true);
    try {
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

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/folders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        groups.value = jsonResponse.map((group) => Groups.fromJson(group)).toList();

      } else {
        Get.snackbar('Error', 'Failed to load groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }

  // دالة لجلب المجلدات الخاصة بالمستخدم
  Future<void> fetchOwnGroups() async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/folders/my-folders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        ownGroups.value = jsonResponse.map((group) => Groups.fromJson(group)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load own groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load own groups: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOtherGroups() async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();
      int? currentUserId = await _sharedPreferencesService.getUserId();

      if (token == null || currentUserId == null) {
        Get.snackbar('Error', 'User is not authenticated');
        isLoading(false);
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('http://195.88.87.77:8888/api/v1/folders/other-folders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Groups> fetchedGroups = jsonResponse.map((group) => Groups.fromJson(group)).toList();

        List<Groups> joinedGroups = [];
        List<Groups> notJoinedGroups = [];

        for (var group in fetchedGroups) {
          bool isMember = group.listOfUsers.any((userInFolder) => userInFolder.id == currentUserId);
          if (isMember) {
            joinedGroups.add(group);
          } else {
            notJoinedGroups.add(group);
          }
        }

        otherGroups.value = fetchedGroups;
        joinedOtherGroups.value = joinedGroups;
        notJoinedOtherGroups.value = notJoinedGroups;

      } else {
        Get.snackbar('Error', 'Failed to load other groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load other groups: $e');
    } finally {
      isLoading(false);
    }
  }

  void showMyGroups() {
    currentGroupList.value = ownGroups.value;
  }

  void showJoinedGroups() {
    currentGroupList.value = joinedOtherGroups.value;
  }

  void showPublicGroups() {
    currentGroupList.value = notJoinedOtherGroups.value;
  }

  Future<void> sendJoinRequest(Groups group) async {
    Get.snackbar('Join Request', 'Request sent to join ${group.name}');
  }

}
