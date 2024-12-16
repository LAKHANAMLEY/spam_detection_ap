import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:spam_delection_app/lib.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint(
      "Push Message received while app in background: ${message.toMap()}");
}

firebase(context) async {
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
    case NotificationType.profileUpdate:
      // profileBloc.add(GetProfileEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycStatus:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycUnderReview:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycApproved:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycSuspended:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycRejected:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycExpired:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycUploaded:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycUpdated:
      // kycBloc.add(GetKYCDetailEvent());
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.transaction:
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.requestToPay:
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.paymentSent:
      // notificationsListBloc
      //     .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.paymentReceived:
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
    // case NotificationType.profileUpdate:
    //   Navigator.of(context).pushNamed(AppRoutes.updateProfile);
    //   break;

    // case NotificationType.kycUnderReview:
    //   Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
    //   break;

    // case NotificationType.kycApproved:
    //   Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
    //   break;

    // case NotificationType.kycSuspended:
    //   Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
    //   break;

    // case NotificationType.kycUploaded:
    //   Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
    //   break;

    // case NotificationType.kycUpdated:
    //   Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
    //   break;

    // case NotificationType.transaction:
    //   transactionDetail(transactionId: message.data["id"]).then((response) {
    //     if (response.code == 200) {
    //       if (response.data != null) {
    //         Navigator.of(context).pushNamed(AppRoutes.transactionHistoryDetail,
    //             arguments: TransactionHistoryDetail(
    //               transaction: TransactionData.fromJson(response.data),
    //             ));
    //       } else {
    //         Navigator.pushNamed(context, AppRoutes.notificationDetail,
    //             arguments: NotificationDetail(
    //               notification: notification,
    //             ));
    //       }
    //     } else {
    //       showToast(response.message);
    //     }
    //   });
    //   break;

    // case NotificationType.requestToPay:
    //   Navigator.of(context).pushNamed(AppRoutes.paymentRequests);
    //   break;

    // case NotificationType.paymentSent:
    //   transactionDetail(transactionId: message.data["id"]).then((response) {
    //     if (response.code == 200) {
    //       if (response.data != null) {
    //         Navigator.of(context).pushNamed(AppRoutes.transactionHistoryDetail,
    //             arguments: TransactionHistoryDetail(
    //               transaction: TransactionData.fromJson(response.data),
    //             ));
    //       } else {
    //         Navigator.pushNamed(context, AppRoutes.notificationDetail,
    //             arguments: NotificationDetail(
    //               notification: notification,
    //             ));
    //       }
    //     } else if (response.code == HTTPResponseStatusCodes.sessionExpireCode) {
    //       sessionExpired(response.message, context);
    //     } else {
    //       showToast(response.message);
    //     }
    //   });
    //   break;

    // case NotificationType.paymentReceived:
    //   transactionDetail(transactionId: message.data["id"]).then((response) {
    //     if (response.code == 200) {
    //       if (response.data != null) {
    //         Navigator.of(context).pushNamed(AppRoutes.transactionHistoryDetail,
    //             arguments: TransactionHistoryDetail(
    //               transaction: TransactionData.fromJson(response.data),
    //             ));
    //       } else {
    //         Navigator.pushNamed(context, AppRoutes.notificationDetail,
    //             arguments: NotificationDetail(
    //               notification: notification,
    //             ));
    //       }
    //     } else {
    //       showToast(response.message);
    //     }
    //   });
    //   break;

    // case NotificationType.invoiceGenerated:
    //   invoiceDetail(invoiceNumber: message.data["id"]).then((response) {
    //     if (response.code == 200) {
    //       if (response.data != null) {
    //         Navigator.pushNamed(context, AppRoutes.invoiceDetail,
    //             arguments: InvoiceDetail(
    //               invoice: response.data?.invoiceData,
    //             ));
    //       } else {
    //         Navigator.pushNamed(context, AppRoutes.notificationDetail,
    //             arguments: NotificationDetail(
    //               notification: notification,
    //             ));
    //       }
    //     } else {
    //       showToast(response.message);
    //     }
    //   });
    //   break;

    // case NotificationType.invoiceUpdated:
    //   invoiceDetail(invoiceNumber: message.data["id"]).then((response) {
    //     if (response.code == 200) {
    //       if (response.data != null) {
    //         Navigator.pushNamed(context, AppRoutes.invoiceDetail,
    //             arguments: InvoiceDetail(
    //               invoice: response.data?.invoiceData,
    //             ));
    //       } else {
    //         Navigator.pushNamed(context, AppRoutes.notificationDetail,
    //             arguments: NotificationDetail(
    //               notification: notification,
    //             ));
    //       }
    //     } else {
    //       showToast(response.message);
    //     }
    //   });
    //   break;

    // case NotificationType.default1:
    //   Navigator.pushNamed(context, AppRoutes.notificationDetail,
    //       arguments: NotificationDetail(
    //         notification: notification,
    //       ));
    //   // bottomNavigationBloc.add(SelectIntEvent(3));
    //   // Navigator.of(context)
    //   //     .pushNamedAndRemoveUntil("/bottombar", (route) => false);
    //   break;

    default:
      bottomNavigationBloc.add(SelectIntEvent(3));
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil("/bottombar", (route) => false);
      break;
  }
  return true;
}
