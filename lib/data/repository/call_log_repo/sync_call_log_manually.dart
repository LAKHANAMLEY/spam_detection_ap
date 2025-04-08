import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SyncCallManuallyResponse> syncCallLogManually(
    {required CallLogEntry callLogs}) async {
  // var body = [];
  // for (int i = 0; i < callLogs.length; i++) {
  var logData = callLogs;
  var body = {
    'simdisplayname': logData.simDisplayName ?? "",
    'phoneaccountid': logData.phoneAccountId ?? "",
    'name': logData.name ?? "",
    'country_code': logData.number?.separatePhoneAndPhoneCode().phoneCode ?? "",
    'mobile_no': logData.number
            ?.separatePhoneAndPhoneCode()
            .phone
            .replaceAll(AppConstants.specialCharAndSpaceRegex, "") ??
        "",
    'call_type': logData.callType?.name ?? "",
    'call_time':
        logData.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
    'call_duration': logData.duration.toString(),
    'call_duration_unit': '1' //1 sec 2 min 3 horus
    // });
  };
  log("${ApiUrlConstants.syncCallLogManually} ${jsonEncode(body)}");

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ApiUrlConstants.syncCallLogManually,
      ));

  request.headers.addAll(await ApiUrlConstants.headers());
  // for (var field in body) {
  request.fields.addAll(body);
  // }

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return SyncCallManuallyResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
