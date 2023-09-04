import 'dart:developer';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// import '../constants/values.dart';

class FcmHelper {
  FcmHelper._internal();
  static final FcmHelper fcmHelper = FcmHelper._internal();
  // FCM Messaging
  static FirebaseMessaging? messaging;

  // Notification lib
  static AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  /// this function will initialize firebase and fcm instance
  Future<void> initFcm() async {
    try {
      // initialize fcm and firebase core
      await Firebase.initializeApp();

      await _setupFcmNotificationSettings();

      await _initNotification();

      await _generateFcmToken();
      FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);

      FirebaseMessaging.onMessageOpenedApp.listen(_fcmForegroundHandler);
    } catch (error) {
      log(error.toString());
    }
  }

  ///handle fcm notification settings (sound,badge..etc)
  Future<void> _setupFcmNotificationSettings() async {
    //show notification with sound and badge
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //NotificationSettings settings
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );
  }

  /// generate and save fcm token if its not already generated (generate only for 1 time)
  Future<void> _generateFcmToken() async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic("all");

      var token = await FirebaseMessaging.instance.getToken();
      log(token.toString());
      if (token != null) {
        await StorageService.writeFcmToken(token);
        // _sendFcmTokenToServer();
      } else {
        await Future.delayed(const Duration(seconds: 1));
        _generateFcmToken();
      }
      // ignore: empty_catches
    } catch (error) {}
  }

  /// this method will be triggered when the app generate fcm
  /// token successfully
  // _sendFcmTokenToServer() {
  //   StorageService.getFcmToken();
  // }

  Future<void> backgroundMessageHandler(RemoteMessage message) async {
    try {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            title: message.notification?.title ?? 'Tittle',
            body: message.notification?.body ?? 'Body',
            channelKey: NotificationChannels.chatChannelKey,
            showWhen: true,
            color: Colors.transparent,
            displayOnBackground: false,
            backgroundColor: Colors.transparent,
            notificationLayout: NotificationLayout.Default,
            autoDismissible: true,
            summary: "summary"),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  ///handle fcm notification when app is closed/terminated
  Future<void> fcmBackgroundHandler(message) async {
    _showNotification(
        id: 1,
        title: message.notification?.title ?? 'Tittle',
        body: message.notification?.body ?? 'Body');

    awesomeNotifications.createNotificationFromJsonData(message.data);

    // return Future.value(true);
  }

  //handle fcm notification when app is open
  Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    _showNotification(
        id: 1,
        title: message.notification?.title ?? 'Tittle',
        body: message.notification?.body ?? 'Body');

    awesomeNotifications.createNotificationFromJsonData(message.data);
  }

  //display notification for user with sound
  _showNotification(
      {required String title, required String body, required int id}) async {
    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();
      } else {
        // u can show notification
        awesomeNotifications.createNotification(
          content: NotificationContent(
              id: id,
              title: title,
              body: body,
              channelKey: NotificationChannels.chatChannelKey,
              showWhen: true,
              color: Colors.transparent,
              displayOnBackground: false,
              backgroundColor: Colors.transparent,
              notificationLayout: NotificationLayout.Default,
              autoDismissible: true,
              summary: "summary"),
        );
      }
    });
  }

  ///init notifications channels
  _initNotification() async {
    await awesomeNotifications.initialize(
      null, // null mean it will show app icon on the notification (status bar)
      [
        NotificationChannel(
            channelKey: NotificationChannels.chatChannelKey,
            channelName: NotificationChannels.chatChannelName,
            channelDescription: 'Notification channel for messages',
            channelShowBadge: true,
            playSound: true,
            enableLights: true,
            enableVibration: true,
            criticalAlerts: true,
            defaultColor: Colors.transparent,
            ledColor: Colors.transparent,
            importance: NotificationImportance.High)
      ],
    );
  }

  Future sendNotificationToUser(
      {required String fcmToken,
      required String title,
      required String body}) async {
    const url = "https://fcm.googleapis.com/fcm/send";

    final headerMap = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          "key=AAAAQYwLq4M:APA91bG8VIA2d5-BqCqxrZ7FL-Mpv-diCluOOjlNXK5zsNTRGAEtuIB7EZEmInPBb2EadBxte6djrv6Gi4ZriQ9NxHiOts-Slch9w6WrGlmixdFa2mXuBDiiUEIp62Zk2Er3KXeWJHfe"
    };

    await Dio().post(url, options: Options(headers: headerMap), data: {
      "to": fcmToken,
      "notification": {"body": body, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "chat_message": "1"
      }
    });

    return true;
  }
}

class NotificationChannels {
  // chat channel (for messages only)
  static String get chatChannelKey => "firebase key";
  static String get chatChannelName => "Firebase Channe";

  static String get chatChannelDescription => "Firebase notifications channels";
}
