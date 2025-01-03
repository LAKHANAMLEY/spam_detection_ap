import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/utils/permission_request.dart';

Future<List<SmsMessage>> getSms() async {
  permissionRequest(Permission.sms);
  SmsQuery query = SmsQuery();
  var sms = await query.querySms(
    kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
  );
  print(sms.first.toMap.toString());
  return sms;
}
