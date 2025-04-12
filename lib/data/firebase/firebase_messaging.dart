import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint(
      "Push Message received while app in background: ${message.toMap()}");
}

firebase(context) async {
  // var status = await permissionRequest(Permission.notification);
  var status = await Permission.notification.status;
  if (status == PermissionStatus.granted) {
    LocalNotificationService.init(context);

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted permission to receive push notification: ${settings.authorizationStatus}');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "Push Message received while app in forground: ${message.toMap()}");
    handleOnMessageByType(message);
    if (message.notification != null) {
      ///local notification
      LocalNotificationService.showNotification(
          0, message.notification?.title, message.notification?.body,
          payload: jsonEncode(message.toMap()));
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    debugPrint(
        "Push Message received while app terminated: ${message?.toMap()}");
    if (message != null) {
      navigateByType(message, context);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint(
        "Push Message received while app is opening: ${message.toMap()}");
    navigateByType(message, context);
  });

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

void handleOnMessageByType(RemoteMessage message) {
  var notificationType = notificationTypeValues.map[message.data['type']];
  switch (notificationType) {
    case NotificationType.membership:
      // profileBloc.add(GetProfileEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    default:
      // bottomNavigationBloc.add(SelectIntEvent(3));
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;
  }
}

Future navigateByType(
  RemoteMessage message,
  context,
  // {NotificationData? notification}
) async {
  var notificationType = notificationTypeValues.map[message.data['type']];
  switch (notificationType) {
    case NotificationType.membership:
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.planList);
      // bottomNavigationBloc.add(SelectIntEvent(3));
      // Navigator.pushNamedAndRemoveUntil(
      //     context, AppRoutes.bottomNavigation, (route) => false);
      break;

    case NotificationType.profileVisitor:
      bottomNavigationBloc.add(SelectIntEvent(3));
      Navigator.pushNamed(
        context,
        AppRoutes.viewedProfile,
      );
      break;

    default:
      Navigator.pushNamed(
        context,
        AppRoutes.notificationList,
      );
      // bottomNavigationBloc.add(SelectIntEvent(3));
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil("/bottombar", (route) => false);
      break;
  }
  return true;
}
