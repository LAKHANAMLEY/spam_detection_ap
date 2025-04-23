import 'package:permission_handler/permission_handler.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:spam_delection_app/models/sms_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/exception_handling.dart';

class SMSController {
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
}
