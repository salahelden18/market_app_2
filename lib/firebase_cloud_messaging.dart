import 'package:firebase_messaging/firebase_messaging.dart';

String? fcmToken;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle incoming messages when the app is in the background or terminated
  print("Message handled in background: ${message.notification?.title}");
}

// Cloud messaging
configureFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle incoming messages when the app is in the foreground
    print("Message received: ${message.notification?.title}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle when a user taps on a notification and the app is in the background or terminated
    print("Message opened app: ${message.notification?.title}");
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

handleFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  fcmToken = token;
  print('FCM Token: $token');
}

requestNotificationPermissions() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  print('User granted permission: ${settings.authorizationStatus}');
}
