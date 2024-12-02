import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Background Notification Received");
  }
}

void showNotification({required String title, required String body}) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

void setupFirebaseMessaging() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      Get.toNamed("/message", arguments: message);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      // Show notification using Get.dialog
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
