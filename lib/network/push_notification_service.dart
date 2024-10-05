import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shepherd_voice/models/item_response.dart';

import '../firebase_options.dart';
import '../screens/shared/navigation_manager.dart';

class PushNotificationService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      PushNotificationService._firebaseMessaging ?? FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _firebaseMessaging = FirebaseMessaging.instance;
    await subscribeToTopic();
    await initializeLocalNotifications();
    await onMessage();
    await onBackgroundMsg();
  }

  static Future<void> subscribeToTopic() async {
    await _firebaseMessaging?.subscribeToTopic('shepherd_voice');
  }

  static Future<void> initializeLocalNotifications() async {
    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onTapNotification,
      onDidReceiveBackgroundNotificationResponse: onTapNotification,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      handleNotificationTap(message?.data.toString());
    });

    /// need this for ios foreground notification
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static NotificationDetails platformChannelSpecifics =
      const NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      priority: Priority.max,
      importance: Importance.max,
    ),
  );

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        // if this is available when Platform.isIOS, you'll receive the notification twice
        await _localNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static getInitialMessage() {
    firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleNotificationTap(message?.data.toString());
      });
    });
  }

  static Future<void> onBackgroundMsg() async {
    // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  /// When app is in the foreground
  @pragma('vm:entry-point')
  static Future<void> onTapNotification(NotificationResponse? response) async {
    handleNotificationTap(response?.payload);
  }

  static handleNotificationTap(String? payload) {
    if (payload != null) {
      Map<String, dynamic?> valueMap = json.decode(payload!);

      ItemResponse item = ItemResponse.fromJson(valueMap);
      NavigationManager.navigate(item: item);
    }
  }

  // static Future<void> backgroundHandler(RemoteMessage message) async {}
}
