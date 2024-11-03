// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
   apiKey: "AIzaSyCodCsuw9P8BhZ_iRffQyO-ua9B4We06K0",
    authDomain: "filemanager-446f0.firebaseapp.com",
    projectId: "filemanager-446f0",
    storageBucket: "filemanager-446f0.firebasestorage.app",
    messagingSenderId: "353396631731",
    appId: "1:353396631731:web:b1221a767d9ac9e031e8c6",
    measurementId: "G-SQ4JY08NJX"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});


//// Please see this file for the latest firebase-js-sdk version:
//// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
//importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
//importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");
//
//firebase.initializeApp({
//   apiKey: "fake",
//    authDomain: "filemanager-446f0.firebaseapp.com",
//    projectId: "filemanager-446f0",
//    storageBucket: "filemanager-446f0.firebasestorage.app",
//    messagingSenderId: "353396631731",
//    appId: "1:353396631731:web:b1221a767d9ac9e031e8c6",
//    measurementId: "G-SQ4JY08NJX"
//});
//
//const messaging = firebase.messaging();
//
//// Optional:
//messaging.onBackgroundMessage((message) => {
//  console.log("onBackgroundMessage", message);
//});