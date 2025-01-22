import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_manager_internet_applications_project/SharedPreferences/shared_preferences_service.dart';
import '../models/Groups_Model.dart';
enum GroupListType { all, myGroups, joinedGroups, publicGroups }

class GroupsController extends GetxController {
  var groups = <Groups>[].obs;
  var ownGroups = <Groups>[].obs;
  var otherGroups = <Groups>[].obs;
  var joinedOtherGroups = <Groups>[].obs;
  var notJoinedOtherGroups = <Groups>[].obs;
  var currentGroupList = <Groups>[].obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  var currentGroupListType = GroupListType.all.obs;

  //PENDING
  //

  @override
  void onInit() {
    fetchGroups();
    fetchOwnGroups();
    fetchOtherGroups();
    super.onInit();
  }
  void searchGroups() {
    List<Groups> filteredGroups = [];

    switch (currentGroupListType.value) {
      case GroupListType.myGroups:
        filteredGroups = ownGroups;
        break;
      case GroupListType.joinedGroups:
        filteredGroups = joinedOtherGroups;
        break;
      case GroupListType.publicGroups:
        filteredGroups = notJoinedOtherGroups;
        break;
      case GroupListType.all:
      default:
        filteredGroups = [...ownGroups, ...otherGroups];
        break;
    }

    if (searchQuery.value.isEmpty) {
      currentGroupList.value = filteredGroups;
    } else {
      currentGroupList.value = filteredGroups.where((group) {
        return group.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    currentGroupList.value = currentGroupList.value.where((group) {
      return !group.listOfUsers.any((user) => user.status == "ACCEPTED");
    }).toList();
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
        groups.value = jsonResponse.map((groupJson) {

          Groups group = Groups.fromJson(groupJson);
          group.listOfUsers.retainWhere((userInFolder) => userInFolder.status == "ACCEPTED");
          return group;
        }).toList();

      } else {
        print("error .................................................................${response.statusCode} ${response.reasonPhrase} ");
        Get.snackbar('Error', 'Failed to load groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("3.................................................................${e}");
    Get.snackbar('Error', 'Failed to load groups: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOwnGroups() async {
    isLoading(true);
    try {
      String? token = await _sharedPreferencesService.getToken();
      print('\n$token');
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        List jsonResponse = json.decode(response.body);

        ownGroups.value = jsonResponse.map((groupJson) {
          Groups group = Groups.fromJson(groupJson);

          group.listOfUsers.retainWhere((userInFolder) => userInFolder.status == "ACCEPTED");

          return group;
        }).toList();

      } else {
        print("error .................................................................${response.statusCode} ${response.reasonPhrase} ");
        Get.snackbar('Error', 'Failed to load own groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("2.................................................................${e}");
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
          group.listOfUsers.retainWhere((userInFolder) => userInFolder.status == "ACCEPTED");

          bool isAcceptedMember = group.listOfUsers.any(
                (userInFolder) => userInFolder.user.id == currentUserId,
          );

          if (isAcceptedMember) {
            joinedGroups.add(group);
          } else {
            notJoinedGroups.add(group);
          }
        }

        otherGroups.value = joinedGroups + notJoinedGroups;
        joinedOtherGroups.value = joinedGroups;
        notJoinedOtherGroups.value = notJoinedGroups;

      } else {
        print("error .................................................................${response.statusCode} ${response.reasonPhrase} ");
        Get.snackbar('Error', 'Failed to load other groups. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("1.................................................................${e}");
      Get.snackbar('Error', 'Failed to load other groups: $e');
    } finally {
      isLoading(false);
    }
  }

  void showMyGroups() {
    currentGroupList.value = ownGroups.value;
    currentGroupListType.value = GroupListType.myGroups;
  }

  void showJoinedGroups() {
    currentGroupList.value = joinedOtherGroups.value;
    currentGroupListType.value = GroupListType.joinedGroups;
  }

  void showPublicGroups() {
    currentGroupList.value = notJoinedOtherGroups.value;
    currentGroupListType.value = GroupListType.publicGroups;
  }

  Future<void> sendJoinRequest(Groups group) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var request = http.Request('POST', Uri.parse('http://195.88.87.77:8888/api/v1/joins/requests'));
      request.body = json.encode({
        "folderId": group.id
      });
      print(group.id);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode==201) {
        // String responseBody = await response.stream.bytesToString();
        // List jsonResponse = json.decode(responseBody);
        Get.snackbar('successful', 'Request sent to join ${group.name}');
      } else {
        print("error .................................................................${response.statusCode} ${response.reasonPhrase} ");
        Get.snackbar('Error', 'already send reguest: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(".................................................................${e}");
      Get.snackbar('Error', 'Failed to send join requests: $e');
    }
  }

}