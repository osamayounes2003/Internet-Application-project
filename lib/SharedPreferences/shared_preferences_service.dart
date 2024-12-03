import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveUserData({
    required int id,
    required String fullname,
    required String email,
    required String role,
    required String token,
    required String refreshToken,

  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('id', id);
    await prefs.setString('fullname', fullname);
    await prefs.setString('email', email);
    await prefs.setString('role', role);
    await prefs.setString('token', token);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
  Future<void> saveRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshToken', refreshToken);
  }

  Future<String?> getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fullname');
  }

  Future<String?> getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<void> setIsLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role);
  }

  Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }
  Future<void> saveDeviceToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceToken', token);
  }

  Future<String?> getDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceToken');
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt('id');
    String? fullname = prefs.getString('fullname');
    String? email = prefs.getString('email');
    String? role = prefs.getString('role');
    String? token = prefs.getString('token');
    String? refreshToken = prefs.getString('refreshToken');

    if (id != null &&
        fullname != null &&
        email != null &&
        role != null &&
        token != null &&
        refreshToken != null) {
      return {
        'id': id,
        'fullname': fullname,
        'email': email,
        'role': role,
        'token': token,
        'refreshToken': refreshToken,
      };
    }
    return null;
  }

  Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
