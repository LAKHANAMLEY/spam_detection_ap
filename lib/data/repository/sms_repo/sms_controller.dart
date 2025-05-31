import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:spam_delection_app/data/models/sms/sms_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/exception_handling.dart';

class SMSController {
  static const _platform = MethodChannel("com.broadlink.protect/chat");

  static Future<void> setDefaultSMSApp() async {
    try {
      var a = await _platform.invokeMethod('setDefaultSms');
      print("Setting default SMS app: $a");
    } on PlatformException catch (e) {
      print("Error setting default SMS app: $e");
    }
  }

  static Future<SmsMessage?> sendSmsByDevice(SmsMessage sms) {
    try {
      SmsSender sender = SmsSender();
      return sender.sendSms(sms);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<SmsMessage>> getDeviceSms(
      {String? address,
      bool sort = true,
      List<SmsQueryKind> kinds = const [SmsQueryKind.Inbox, SmsQueryKind.Sent],
      int? count,
      int? start,
      int? threadId}) async {
    var status = await Permission.sms.status;

    // var smsPermission = await permissionRequest(Permission.sms);
    if (status.isGranted) {
      SmsQuery query = SmsQuery();
      var sms = await query.querySms(
          count: count,
          kinds: kinds,
          address: address,
          sort: sort,
          start: start,
          threadId: threadId);
      // log("Device sms : " + jsonEncode(sms.map((e) => e.toMap).toList()));
      return sms;
    } else {
      // log("Permission status: ${status.name}");
      throw PermissionException("SMS permission status : ${status.name}");
      // return [];
    }
  }

  static deleteDeviceSms(SmsDetail sms) async {
    SmsRemover smsRemover = SmsRemover();
    return await smsRemover.removeSmsById(int.tryParse(sms.id ?? "0") ?? 0,
        int.tryParse(sms.threadId ?? "0") ?? 0);
  }

  static Future<SmsMessage> getLastSms(SmsMessage message) async {
    ///Check if default app then you can not get the received message from sms app because if broadlink is your default app then message will not be received by the sms app
    /// If you want to get the received message then you have to set broadlink as default sms app
    // if (await _platform.invokeMethod('isDefaultSmsApp')) {
    //   log("Broadlink is default sms app, cannot get received message");
    //   return message;
    // }
    // log("Broadlink is not default sms app, getting last message");
    // if (message.threadId == null) {
    //   log("Message threadId is null, cannot get last message");
    //   return message;
    // }
    // // Wait for a while to ensure the message is received
    // log("Waiting for 1 second to get the last message");
    // // This delay is to ensure that the message has been processed by the SMS app
    // // You can adjust the delay time as per your requirement
    // // If you want to get the last message immediately, you can remove this delay
    // // But it may not work as expected if the message is not processed yet
    // log("Thread ID: ${message.threadId}");
    // log("Message ID: ${message.id}");
    // log("Message Address: ${message.address}");
    // log("Message Body: ${message.body}");
    // log("Message Date: ${message.date}");
    // log("Message Read: ${message.isRead}");
    // log("Message Type: ${message.kind}");
    // log("Message Status: ${message.state}");
    // log("Message ToMap: ${message.toMap}");
    // log("Getting last message from thread ID: ${message.threadId}");
    // Wait for a while to ensure the message is received

    // await Future.delayed(Duration(seconds: 1));
    // var messages =
    //     await SMSController.getDeviceSms(threadId: message.threadId, count: 1);
    // log("Received Message: ${message.toMap}");
    // log("Last Message: ${messages.first.toMap}");
    // return messages.first;

    return message;
  }
}
