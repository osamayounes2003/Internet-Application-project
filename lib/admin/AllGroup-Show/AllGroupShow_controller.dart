import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SharedPreferences/shared_preferences_service.dart';
import '../../user/Groups/models/Groups_Model.dart';

class GroupsAdminController extends GetxController {
  var isLoading = false.obs;
  var currentGroupList = <Groups>[].obs;
  var searchQuery = ''.obs;
  var acceptedList = <UserInFolder>[].obs;
  var invitationList = <UserInFolder>[].obs;
  var requestList = <UserInFolder>[].obs;

  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchGroups();
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
print(token);
      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      var request = http.Request('GET', Uri.parse('http://195.88.87.77:8888/api/v1/folders'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> data = json.decode(responseBody);

        currentGroupList.value = data.map((groupJson) => Groups.fromJson(groupJson)).toList();

      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error fetching groups: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void categorizeUsersByStatus(int groupId) {
    // Clear the lists before refilling
    acceptedList.clear();
    invitationList.clear();
    requestList.clear();

    Groups? group = currentGroupList.firstWhere((g) => g.id == groupId);

    if (group == null) return;

    for (var userInFolder in group.listOfUsers) {
      switch (userInFolder.status) {
        case 'ACCEPTED':
          if (!acceptedList.any((user) => user.user.id == userInFolder.user.id)) {
            acceptedList.add(userInFolder);
          }
          break;

        case 'INVITATION':
          if (!invitationList.any((user) => user.user.id == userInFolder.user.id) &&
              !acceptedList.any((user) => user.id == userInFolder.id)) {
            invitationList.add(userInFolder);
          }
          break;

        case 'REQUEST':
          if (!requestList.any((user) => user.user.id == userInFolder.user.id) &&
              !acceptedList.any((user) => user.id == userInFolder.id)) {
            requestList.add(userInFolder);
          }
          break;

        default:
          break;
      }
    }
  }

  void searchGroups() {
    if (searchQuery.value.isEmpty) {
      fetchGroups();
    } else {
      currentGroupList.value = currentGroupList.where((group) {
        return group.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  Future<List<Groups>> fetchGroupsByAdmin(int userId) async {
    try {
      return currentGroupList.where((group) => group.owner!.id == userId).toList();
    } catch (e) {
      print("Error fetching admin groups: $e");
      return [];
    }
  }

  Future<List<Groups>> fetchGroupsByMember(int userId) async {
    try {
      return currentGroupList
          .where((group) => group.listOfUsers.any((user) => user.user.id == userId))
          .toList();
    } catch (e) {
      print("Error fetching member groups: $e");
      return [];
    }
  }

  Future<List<UserInFolder>> getUsersByFolderId(int folderId) async {
    await fetchGroups();
    try {
      Groups? group = currentGroupList.firstWhere((g) => g.id == folderId);
      for (var group in currentGroupList) {
        print("Group Name: ${group.name}, Group ID: ${group.id}");
        for (var user in group.listOfUsers) {
          print("  User: ${user.user.fullname}, Status: ${user.status}");
        }
      }
      if (group == null) {
        print("Group not found with id: $folderId");
        return [];
      }
      print("List of Users in Folder:");
      for (var user in group.listOfUsers) {
        print("User: ${user.user.fullname}, Status: ${user.status}");
      }      return group.listOfUsers.where((user) => user.status == "ACCEPTED").toList();
    } catch (e) {
      print("Error fetching users by folder ID: $e");
      return [];
    }
  }


}
