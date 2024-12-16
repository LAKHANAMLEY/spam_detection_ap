import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spam_delection_app/lib.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('com.bctpay', 'BCTPay',
          channelDescription: 'BCTPay notification channel',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  static const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails();
  static const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: iosNotificationDetails);

  static showNotification(
    int id,
    String? title,
    String? body, {
    String? payload,
  }) {
    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: payload);
  }

  static Future<bool> requestPermission() async {
    late bool? result;
    if (Platform.isAndroid) {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    return result ?? false;
  }

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(notificationCategories: [
    DarwinNotificationCategory(
      'demoCategory',
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          'id_3',
          'Action 3',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ]);

  static init(context) async {
    requestPermission();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
            );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) {
      onDidReceiveNotificationResponse(notificationResponse, context);
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  static onDidReceiveNotificationResponse(
      NotificationResponse details, context) {
    var message = RemoteMessage.fromMap(jsonDecode(details.payload ?? ""));
    navigateByType(message, context);
  }

  static onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showToast(title ?? "");
  }

  static void notificationTapBackground(NotificationResponse details) {
    showToast(details.payload ?? "");
  }
}
