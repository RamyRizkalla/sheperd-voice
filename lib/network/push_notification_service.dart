import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shepherd_voice/models/film_response.dart';

import '../firebase_options.dart';
import '../screens/shared/navigation_manager.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  Future initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Handling a background message: ${message.messageId}");
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
          message.messageId.hashCode,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              // color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentSound: true,
              presentAlert: true,
              presentBadge: true,
            ),
          ),
          payload: 'Open from Local Notification',
        );
      }
    });

    // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    return token;
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }
}

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeLocalNotifications();
    await FCMProvider.onMessage();
    await FirebaseService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async =>
      await FirebaseMessaging.instance.getToken();

  static FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    final InitializationSettings _initSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await FirebaseService._localNotificationsPlugin.initialize(_initSettings,
        onDidReceiveNotificationResponse: FCMProvider.onTapNotification);

    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static NotificationDetails platformChannelSpecifics = NotificationDetails(
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
        await FirebaseService._localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FCMProvider.backgroundHandler);
  }
}

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;

  static void setContext(BuildContext context) =>
      FCMProvider._context = context;

  /// when app is in the foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {
    // var encodedString = jsonEncode(response?.payload);
    if (response?.payload != null) {
      Map<String, dynamic> valueMap = json.decode(response!.payload!);

      FilmResponse item = FilmResponse.fromJson(valueMap);
      NavigationManager.navigate(item: item);
    }
  }

  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (FCMProvider._refreshNotifications != null) await FCMProvider._refreshNotifications!(true);
      // if this is available when Platform.isIOS, you'll receive the notification twice
      if (Platform.isAndroid) {
        await FirebaseService._localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {}
}
