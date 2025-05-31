import 'dart:developer';

import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

class CallKitHelper {
  showCallKitIncoming() async {
    await FlutterCallkitIncoming.showCallkitIncoming(CallKitParams(
      id: 'unique-call-id',
      nameCaller: 'John Doe',
      avatar: 'https://example.com/avatar.jpg',
      handle: '123456789',
      type: 0, // 0 = audio, 1 = video
      duration: 30000, // milliseconds
    ));
  }

  static Future<void> showCallerID(String phoneNumber, String callerName,
      {bool isSpam = false}) async {
    try {
      var params = CallKitParams(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        // id: uuid.v4(), // <-- this generates a valid UUID
        nameCaller: isSpam ? '⚠️ SPAM: $callerName' : callerName,
        handle: phoneNumber,
        type: 0, // 0 = audio call
        textAccept: 'Accept',
        textDecline: 'Decline',
        duration: 30000,
        android: AndroidParams(
          isCustomNotification: true,
          isShowLogo: true,
          ringtonePath: 'system_ringtone_default', // customize if needed
        ),
        ios: IOSParams(
          iconName: 'Icon-App-1024x1024@1x.png',
          handleType: 'number',
          supportsVideo: false,
        ),
      );

      // await FlutterCallkitIncoming.showCallkitIncoming(params);
      await FlutterCallkitIncoming.startCall(params);
    } catch (e) {
      print("Error showing caller ID: $e");
    }
  }

  static listenCallEvent() {
    FlutterCallkitIncoming.onEvent.listen((event) {
      log(event?.event.name ?? "");
      log(event?.body ?? "");
      showCallerID(event?.body.toString() ?? "", "John doe");
      switch (event?.event) {
        case Event.actionCallAccept:
          break;
        case Event.actionCallDecline:
        case Event.actionCallEnded:
          // Handle declined/ended call
          break;
        case null:
        // TODO: Handle this case.

        case Event.actionDidUpdateDevicePushTokenVoip:
        // TODO: Handle this case.

        case Event.actionCallIncoming:
        // TODO: Handle this case.

        case Event.actionCallStart:
        // TODO: Handle this case.

        case Event.actionCallTimeout:
        // TODO: Handle this case.

        case Event.actionCallCallback:
        // TODO: Handle this case.

        case Event.actionCallToggleHold:
        // TODO: Handle this case.

        case Event.actionCallToggleMute:
        // TODO: Handle this case.

        case Event.actionCallToggleDmtf:
        // TODO: Handle this case.

        case Event.actionCallToggleGroup:
        // TODO: Handle this case.

        case Event.actionCallToggleAudioSession:
        // TODO: Handle this case.

        case Event.actionCallCustom:
        // TODO: Handle this case.
      }
    });
  }
}
