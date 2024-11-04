import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotifications {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // request notification permission
  static Future<void> init() async {
    await _firebaseMessaging.requestPermission();

    getFCMToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Received a message: ${message.notification?.title}, ${message.notification?.body}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message clicked!");
    });
  }

  static Future<String?> getFCMToken({int maxRetries = 3}) async {
    try {
      String? token;
      token = await _firebaseMessaging.getToken(
          vapidKey:
              "BMUyQlbb9AGDSGapyT3TB-zUoVRCf0fVzt5rlZmAhU19m9pzqiuRRphdqBSfznrnB2qYZ3QotjlCbncK8X5OwZo");
      print("Web device token: $token");
      return token;
    } catch (e) {
      print("Failed to get device token");
      if (maxRetries > 0) {
        print("Retrying in 10 seconds...");
        await Future.delayed(Duration(seconds: 10));
        return getFCMToken(maxRetries: maxRetries - 1);
      } else {
        return null;
      }
    }
  }
}
