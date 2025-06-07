// import 'package:flutter_callkit_incoming/entities/android_params.dart';
// import 'package:flutter_callkit_incoming/entities/call_event.dart';
// import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// import 'package:flutter_callkit_incoming/entities/ios_params.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:spam_delection_app/lib.dart';

class CallKitHelper {
  // showCallKitIncoming() async {
  //   FlutterCallkitIncoming.getDevicePushTokenVoIP();
  //   await FlutterCallkitIncoming.showCallkitIncoming(CallKitParams(
  //     id: 'unique-call-id',
  //     nameCaller: 'John Doe',
  //     avatar: 'https://example.com/avatar.jpg',
  //     handle: '123456789',
  //     type: 0, // 0 = audio, 1 = video
  //     duration: 30000, // milliseconds
  //   ));
  // }

  static Future<void> showCallerID(
      String phoneNumber, String callerName, int duration,
      {bool isSpam = false}) async {
    try {
      // FlutterCallkitIncoming.getDevicePushTokenVoIP();
      // var params = CallKitParams(
      //   // id: DateTime.now().millisecondsSinceEpoch.toString(),
      //   id: const Uuid().v4(), // Generates a valid UUID
      //   // id: uuid.v4(), // <-- this generates a valid UUID
      //   nameCaller: isSpam ? '⚠️ SPAM: $callerName' : callerName,
      //   handle: phoneNumber,
      //   type: 0, // 0 = audio call
      //   textAccept: 'Accept',
      //   textDecline: 'Decline',
      //   duration: duration,
      //   android: AndroidParams(
      //     isCustomNotification: true,
      //     isShowLogo: true,
      //     ringtonePath: 'system_ringtone_default', // customize if needed
      //   ),
      //   ios: IOSParams(
      //     iconName: 'Icon-App-1024x1024@1x.png',
      //     handleType: 'number',
      //     supportsVideo: false,
      //   ),
      // );

      // await FlutterCallkitIncoming.showCallkitIncoming(params);

      // await FlutterCallkitIncoming.startCall(params);
      ConnectycubeFlutterCallKit.showCallNotification(CallEvent(
          sessionId: phoneNumber,
          callType: 0,
          callerId: 1,
          callerName: callerName,
          opponentsIds: Set()));
    } catch (e) {
      print("Error showing caller ID: $e");
    }
  }

  static listenCallEvent(BuildContext context) {
    // FlutterCallkitIncoming.getDevicePushTokenVoIP();
    var token = ConnectycubeFlutterCallKit.onTokenRefreshed;
    showToast(token.toString());
    ConnectycubeFlutterCallKit.instance.init(
      onCallAccepted: (event) =>
          ConnectycubeFlutterCallKit.showCallNotification(event),
      onCallIncoming: (event) =>
          ConnectycubeFlutterCallKit.showCallNotification(event),
      onCallRejected: (event) =>
          ConnectycubeFlutterCallKit.showCallNotification(event),
    );
    ConnectycubeFlutterCallKit.initEventsHandler();

    // FlutterCallkitIncoming.onEvent.listen((event) {
    //   log(event?.event.name ?? "");
    //   showToast(event?.body.toString());
    //   log(jsonEncode(event?.body ?? ""));
    //   final CallData callData = CallData.fromJson(event?.body);
    //   context.read<CallLogDBBloc>().add(SyncDBCallLogHistory(
    //         mobileNo:
    //             callData.nameCaller.separatePhoneAndPhoneCode().phone ?? "",
    //         callLog: CallLogEntry(
    //           number:
    //               callData.nameCaller.separatePhoneAndPhoneCode().phone ?? "",
    //           callType: CallTypeHelper.getCallLogType(
    //               callData?.type == 0 ? "incoming" : "outgoing"),
    //           timestamp: DateTime.now().millisecondsSinceEpoch,
    //           duration: callData.duration,
    //         ),
    //       ));
    //   showCallerID(callData.nameCaller, callData.nameCaller,
    //       callData.ios.audioSessionPreferredIOBufferDuration.toInt(),
    //       isSpam: true); // Example usage, replace with actual data
    //   switch (event?.event) {
    //     case Event.actionCallAccept:
    //       break;
    //     case Event.actionCallDecline:
    //     case Event.actionCallEnded:
    //       // Handle declined/ended call
    //       break;
    //     case null:
    //     // TODO: Handle this case.

    //     case Event.actionDidUpdateDevicePushTokenVoip:
    //     // TODO: Handle this case.

    //     case Event.actionCallIncoming:
    //     // TODO: Handle this case.

    //     case Event.actionCallStart:
    //     // TODO: Handle this case.

    //     case Event.actionCallTimeout:
    //     // TODO: Handle this case.

    //     case Event.actionCallCallback:
    //     // TODO: Handle this case.

    //     case Event.actionCallToggleHold:
    //     // TODO: Handle this case.

    //     case Event.actionCallToggleMute:
    //     // TODO: Handle this case.

    //     case Event.actionCallToggleDmtf:
    //     // TODO: Handle this case.

    //     case Event.actionCallToggleGroup:
    //     // TODO: Handle this case.

    //     case Event.actionCallToggleAudioSession:
    //     // TODO: Handle this case.

    //     case Event.actionCallCustom:
    //     // TODO: Handle this case.
    //   }
    // });
  }
}
