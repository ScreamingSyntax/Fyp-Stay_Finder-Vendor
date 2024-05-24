import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../presentation/widgets/widgets_exports.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    final androidInitialization =
        AndroidInitializationSettings("@drawable/logo");
    final iosInitialization = DarwinInitializationSettings();
    final intializationSetting = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);
    await _flutterLocalNotificationsPlugin.initialize(
      intializationSetting,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleMessage(context, message);
      },
    );
    // _flutterLocalNotificationsPlugin.initialize(initializationSettings)
  }

  Future<void> setUpInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print("This is an intialize message ${initialMessage}");
    // if (initialMessage != null) {
    //   handleMessage(context, initialMessage);
    // }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provinsonal permission");
    } else {
      print("Not granted");
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        // print(message.data);
        print("This is message here ${message.data}");
        if (Platform.isAndroid) {
          initLocalNotifications(context, message);
          showNotification(message);
        }
        if (Platform.isIOS) {
          foregroundMessage();
        }
      }
    });
  }

  // String createPayload(RemoteMessage message) {
  //   return message.data['type'];
  // }

  Future<void> showNotification(RemoteMessage message) async {
    // var payload = createPayload(message);
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        "High Importance notification",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker',
            channelDescription: "This is your channel description");
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    // _flutterLocalNotificationsPlugin
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        1,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    // print(object);
    print("This is another message ${message.data['type']}");
    // if (message.data['type'] == "msg") {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               MessageScreen(id: int.parse(message.data['id']))));
  }
}
