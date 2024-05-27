import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/order/presentation/view_models/active_order/current_active_orders_cubit.dart';
import 'package:market_app_2/main.dart';

String? fcmToken;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle incoming messages when the app is in the background or terminated
  print("Message handled in background: ${message.notification?.title}");
}

// Cloud messaging
configureFirebaseMessaging() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // Handle incoming messages when the app is in the foreground
    print(
        '=============================================================================');
    print('----- Message Body -----');
    print("Message handled in background: ${message.notification?.title}");
    print('----- Notification Body -----');
    print('>>>>>>>>>>>>>>>>>>>>>>>> ${message.data}');
    print(
        '=============================================================================');
    await navigatorKey.currentContext
        ?.read<CurrentActiveOrderCubit>()
        .getActiveOrders();
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
