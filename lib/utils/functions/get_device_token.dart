import 'dart:developer';

// import 'dart:math';

import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:spam_delection_app/lib.dart';

Future<String?> getVoipToken() async {
  try {
    // String? token = await FlutterCallkitIncoming.getDevicePushTokenVoIP();
    // if (token?.isEmpty ?? true) {
    final String? token = await ConnectycubeFlutterCallKit.getToken();
    // }
    showToast("🚀 VoIP Token: $token");
    return token;
  } catch (e) {
    showToast("⚠️ Error getting VoIP token: $e");
    return null;
  }
}

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
