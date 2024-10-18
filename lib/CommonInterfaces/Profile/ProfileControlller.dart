import 'package:get/get.dart';
import '../../SharedPreferences/shared_preferences_service.dart';

class ProfileController extends GetxController {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  var fullname = ''.obs;
  var email = ''.obs;
  var role = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      isLoading(true);

      Map<String, dynamic>? data = await _sharedPreferencesService.getUserData();

      if (data != null) {
        fullname.value = data['fullname'] ?? '';
        email.value = data['email'] ?? '';
        role.value = data['role'] ?? '';

      } else {
        Get.snackbar("Error", "No user data found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load user data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    await _sharedPreferencesService.clearUserData();
    Get.snackbar("Success", "Logged out successfully");
    Get.offAllNamed('/login');
  }
}
