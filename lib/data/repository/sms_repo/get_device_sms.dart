import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

import '../../../lib.dart';

Future<List<SmsMessage>> getDeviceSms() async {
  var status = await Permission.sms.status;

  // var smsPermission = await permissionRequest(Permission.sms);
  if (status.isGranted ?? false) {
    SmsQuery query = SmsQuery();
    var sms = await query.querySms(
      kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent],
    );
    // print(sms.first.toMap.toString());
    return sms;
  } else {
    log("Permission status: ${status.name}");
    throw PermissionException("SMS permission status : ${status.name}");
    // return [];
  }
}
