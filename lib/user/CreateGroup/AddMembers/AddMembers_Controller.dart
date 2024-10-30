import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../SharedPreferences/shared_preferences_service.dart';
import 'AddMembers_Model.dart';

class AddMembersController extends GetxController {
  var users = <UserModel>[].obs;
  var filteredItems = <String>[].obs;
  var isLoading = true.obs;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }


  Future<void> fetchUsers() async {
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }
      isLoading(true);
      var headers = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      };

      var request = http.Request('GET', Uri.parse('http://195.88.87.77:8888/api/v1/users'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);

        users.value = (jsonData as List).map((user) => UserModel.fromJson(user)).toList();
        print("Fetched users: ${users.toList()}"); // إضافة هذا السطر للتحقق من المستخدمين المحملين
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading(false);
    }
  }


  // Future<void> fetchUsers() async {
  //   try {
  //     String? token = await _sharedPreferencesService.getToken();
  //
  //     if (token == null) {
  //       Get.snackbar('Error', 'User is not authenticated');
  //       return;
  //     }
  //     isLoading(true);
  //     var headers = {
  //       'Accept': '*/*',
  //       'Authorization': 'Bearer $token'
  //     };
  //
  //     var request = http.Request('GET', Uri.parse('http://195.88.87.77:8888/api/v1/users'));
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       var responseBody = await response.stream.bytesToString();
  //       var jsonData = json.decode(responseBody);
  //
  //       users.value = (jsonData as List).map((user) => UserModel.fromJson(user)).toList();
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print("Error fetching users: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }



  void filterUsers(String query) {
    filteredItems.value = users
        .where((member) => member.fullname.toLowerCase().contains(query.toLowerCase()))
        .map((member) => member.fullname)
        .toList();
  }


  Future<void> addUser(int folderId, int userId) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      if (token == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token'
      };

      var request = http.Request('PUT', Uri.parse('http://195.88.87.77:8888/api/v1/folders/users'));
      request.body = json.encode({"folderId": folderId, "userId": userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        Get.snackbar("Success", "added Successfuly");
        print(await response.statusCode);
      } else {
        print(response.statusCode);
      }
    }
    catch(e){
      Get.snackbar("error", "$e");
    }
  }
}
