import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../firebase_options.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> requestNotificationPermission({int maxRetries = 3}) async {
  await FirebaseMessaging.instance.requestPermission();
  // String? token = await FirebaseMessaging.instance.getToken(
  //     vapidKey: "BMUyQlbb9AGDSGapyT3TB-zUoVRCf0fVzt5rlZmAhU19m9pzqiuRRphdqBSfznrnB2qYZ3QotjlCbncK8X5OwZo");
  // print("FCM Token: $token");
  try {
    String? token;
    token = await FirebaseMessaging.instance.getToken(
        vapidKey:
        "BMUyQlbb9AGDSGapyT3TB-zUoVRCf0fVzt5rlZmAhU19m9pzqiuRRphdqBSfznrnB2qYZ3QotjlCbncK8X5OwZo");
    print("Web device token: $token");
  } catch (e) {
    print("Failed to get device token");
    if (maxRetries > 0) {
      print("Retrying in 10 seconds...");
      await Future.delayed(Duration(seconds: 10));
      return requestNotificationPermission(maxRetries: maxRetries - 1);
    } else {
      return null;
    }
  }
}
