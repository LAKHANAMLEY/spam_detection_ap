import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

import '../../../lib.dart';

Future<List<SmsMessage>> getSms() async {
  var smsPermission = await permissionRequest(Permission.sms);
  if (smsPermission?.isGranted ?? false) {
    SmsQuery query = SmsQuery();
    var sms = await query.querySms(
      kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
    );
    // print(sms.first.toMap.toString());
    return sms;
  } else {
    log("Permission status: ${smsPermission?.name}");
    return [];
  }
}
