import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../firebase_options.dart';
import '../../SharedPreferences/shared_preferences_service.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> requestNotificationPermission({int maxRetries = 3}) async {
  final _sharedPreferencesService = SharedPreferencesService();

  await FirebaseMessaging.instance.requestPermission();

  try {
    String? token = await FirebaseMessaging.instance.getToken(
      vapidKey: "BMUyQlbb9AGDSGapyT3TB-zUoVRCf0fVzt5rlZmAhU19m9pzqiuRRphdqBSfznrnB2qYZ3QotjlCbncK8X5OwZo",
    );

    if (token != null) {
      print("Web device token: $token");

      await _sharedPreferencesService.saveDeviceToken(token);
    }
  } catch (e) {
    print("Failed to get device token");
    if (maxRetries > 0) {
      print("Retrying in 3 seconds...");
      await Future.delayed(Duration(seconds: 3));
      return requestNotificationPermission(maxRetries: maxRetries - 1);
    }
  }
}
