import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import '../../view/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising localnotification plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // function to request notifications permissions
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      // AppSettings.openNotificationSettings();
      print('user denied permission');
    }
  }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        // handle interaction when app is active for android
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) async {
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification!.android;

      // if (kDebugMode) {
      //   print("notifications title:${notification!.title}");
      //   print("notifications body:${notification.body}");
      //   print('count:${android!.count}');
      //   print('data:${message.data.toString()}');
      // }
      // FlutterAppBadger.updateBadgeCount(2);

      if (Platform.isAndroid) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        bool isChecked = preferences.getBool('isChecked')!;
        if (isChecked) {
          initLocalNotifications(context, message);
          showNotification(message);
        }
      }

      // if (Platform.isIOS) {
      // }
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableLights: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    if (Platform.isIOS) {
      FlutterAppBadger.updateBadgeCount(1);
    }
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        // message.notification!.title.toString(),
        // message.notification!.body.toString(),
        message.data['title'].toString(),
        message.data['body'].toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isChecked = false;
    if (preferences.getBool('isChecked') != null) {
      isChecked = preferences.getBool('isChecked')!;
    } else {
      isChecked = false;
    }

    //  isChecked = (preferences.getBool('isChecked')!=null)?preferences.getBool('isChecked'): false;
    if (isChecked) {
      // when app is terminated
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print(isChecked);
        handleMessage(context, initialMessage);
      }

      //when app is in  background
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(isChecked);
        handleMessage(context, event);
      });
    }
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => SplashView(
                arguments: message.data,
              )),
      (Route<dynamic> route) => false,
    );
  }
}
