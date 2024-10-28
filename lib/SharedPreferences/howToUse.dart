// كيفية استخدام توابع SharedPreferencesService:

// جلب التوكن
/// String? token = await _sharedPreferencesService.getToken();
/// print('User Token: $token');

// جلب بيانات المستخدم بالكامل
/// Map<String, dynamic>? userData = await _sharedPreferencesService.getUserData();
/// if (userData != null) {
///   print('User ID: ${userData['id']}');
///   print('Full Name: ${userData['fullname']}');
///   print('Email: ${userData['email']}');
///   print('Role: ${userData['role']}');
///   print('Token: ${userData['token']}');
/// }


// حذف بيانات المستخدم (عند تسجيل الخروج)
/// await _sharedPreferencesService.clearUserData();
/// Get.offAllNamed('login_screen');


// وهكذا..