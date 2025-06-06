import 'dart:developer';

import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/data/repository/call_log_repo/send_voip_push.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:url_launcher/url_launcher.dart';

class CallController {
  static const callChannel = MethodChannel('com.broadlink.protect/call');

  static Future<List<CallLogEntry>> getDeviceCallLogs({
    String? number,
    DateTime? dateTimeFrom,
    DateTime? dateTimeTo,
  }) async {
    var phonePermissionStatus = await Permission.phone.status;
    // var phonePermissionStatus = await permissionRequest(Permission.phone);
// GET WHOLE CALL LOG
    // Iterable<CallLogEntry> entries = await CallLog.get();
    if ((phonePermissionStatus.isGranted)) {
      Iterable<CallLogEntry> entries = await CallLog.query(
        number: number,
        dateTimeFrom: dateTimeFrom,
        dateTimeTo: dateTimeTo,
      );
      return entries.toList();
    } else {
      // log("Contact Permission status: ${contactPermissionStatus?.name}");
      log("Phone Permission status: ${phonePermissionStatus.name}");
      // return [];
      throw PermissionException(
          "Phone Permission status : ${phonePermissionStatus.name}");
    }

// QUERY CALL LOG (ALL PARAMS ARE OPTIONAL)
    // var now = DateTime.now();
    // int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
    // int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;
    // Iterable<CallLogEntry> entries = await CallLog.query(
    //   dateFrom: from,
    //   dateTo: to,
    //   durationFrom: 0,
    //   durationTo: 60,
    //   name: 'John Doe',
    //   number: '901700000',
    //   type: CallType.incoming,
    // );
  }

  static Future<void> setDefaultCallingApp() async {
    try {
      await callChannel.invokeMethod('requestDefaultDialer');
    } on PlatformException catch (e) {
      print("Error setting default Calling app: $e");
    }
  }

  static Future<void> endCall() async {
    try {
      final result = await callChannel.invokeMethod('endCall');
      print(result); // Handle the result
    } catch (e) {
      print("Error ending call: $e");
    }
  }

  static Future<void> addCall() async {
    try {
      final result = await callChannel.invokeMethod('addCall');
      print(result); // Handle the result
    } catch (e) {
      print("Error adding call: $e");
    }
  }

  static Future<void> mute() async {
    try {
      final result = await callChannel.invokeMethod('mute');
      print(result); // Handle the result
    } catch (e) {
      print("Error muting: $e");
    }
  }

  static Future<void> unmute() async {
    try {
      final result = await callChannel.invokeMethod('unmute');
      print(result); // Handle the result
    } catch (e) {
      print("Error unmuting: $e");
    }
  }

  static Future<bool?> makeCall(String mobileNumber) async {
    try {
      if (Platform.isIOS) {
        await sendVoipPush(mobileNumber);
        return launchUrl(Uri.parse('tel:$mobileNumber'));
      } else {
        return await DirectCallPlus.makeCall(mobileNumber);
      }
    } catch (e) {
      showToast("Error making call: $e");
      return false;
    }
  }
}
