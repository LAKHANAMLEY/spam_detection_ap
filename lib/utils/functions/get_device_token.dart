import 'dart:developer';
import 'dart:io';

// import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getDeviceToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    var apnToken = await messaging.getAPNSToken();
    log(apnToken ?? "");
    String? token = await messaging.getToken();
    print('Device Token: $token');
    return token;
  } catch (e) {
    log(e.toString());
    return "12345";
  }
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
