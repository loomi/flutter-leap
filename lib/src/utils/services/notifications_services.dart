import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> _requestPermission() async {
    if (Platform.isAndroid) return;

    await _messaging.requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  static Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  Future setup() async {
    await _requestPermission();

    await initialize();

    await _configureAndroidChannel();

    await _openInitialScreenFromMessage();
  }

  Future<void> initialize() async {
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings();

    // #2
    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3
    await _localNotificationsPlugin.initialize(initSettings).then((_) async {
      log('setupPlugin: setup success ${(await FirebaseMessaging.instance.getToken())}');
    }).catchError((Object error) {
      log('Error: $error');
    });
  }

  Future<void> _configureAndroidChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'BreakingCodeChannel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _openInitialScreenFromMessage() async {
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage?.data != null) {
      log(initialMessage!.data.toString());
    }
  }

  invokeLocalNotification(RemoteMessage remoteMessage) async {
    RemoteNotification? notification = remoteMessage.notification;
    AndroidNotification? android = remoteMessage.notification?.android;

    if (notification != null && android != null) {
      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'BreakingCodeChannel', // id
            'High Importance Notifications', // title
            channelDescription:
                'This channel is used for important notifications.',
            icon: android.smallIcon,
          ),
        ),
        payload: jsonEncode(remoteMessage.data),
      );
    }
  }
}
