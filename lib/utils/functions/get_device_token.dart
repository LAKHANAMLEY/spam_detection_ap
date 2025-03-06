
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getDeviceToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print('Device Token: $token');
  return token;
}

String getDeviceType() {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  } else {
    return 'unknown';
  }
}