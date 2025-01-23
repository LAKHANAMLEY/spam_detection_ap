import 'package:permission_handler/permission_handler.dart';

import '../../../lib.dart';

Future<List<SmsMessage>> getSms() async {
  permissionRequest(Permission.sms);
  SmsQuery query = SmsQuery();
  var sms = await query.querySms(
    kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
  );
  // print(sms.first.toMap.toString());
  return sms;
}
