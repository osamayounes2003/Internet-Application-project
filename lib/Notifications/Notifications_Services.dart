import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// final navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Background Notification Received");
  }
}

void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        )
      ],
    ),
  );
}

void setupFirebaseMessaging() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {

      showNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
      );
    }
  });
}

Future<RemoteMessage?> getInitialMessage() async {
  return await FirebaseMessaging.instance.getInitialMessage();
}

//
// if (message != null) {
// print("Launched from terminated state");
// Future.delayed(Duration(seconds: 1), () {
// navigatorKey.currentState!.pushNamed("/message", arguments: message);
// });
// }