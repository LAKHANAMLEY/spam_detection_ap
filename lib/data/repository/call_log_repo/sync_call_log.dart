import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> syncCallLog({required List<CallLogEntry> callLogs}) async {
  // log(jsonEncode(callLogs));
  List<Map<String, String>> body = [];
  for (int i = 0; i < callLogs.length; i++) {
    var log = callLogs[i];
    body.add(
      {
        'simdisplayname': log.simDisplayName ?? "",
        'phoneaccountid': log.phoneAccountId ?? "",
        'name': log.name ?? "",
        'country_code': log.number?.separatePhoneAndPhoneCode().phoneCode ?? "",
        'mobile_no': log.number
                ?.separatePhoneAndPhoneCode()
                .phone
                .replaceAll(AppConstants.specialCharAndSpaceRegex, "") ??
            "",
        'call_type': log.callType?.name ?? "",
        'call_time':
            log.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
        'call_duration': log.duration.toString(),
        'call_duration_unit': '1' //1 sec 2 min 3 horus
      },
    );
  }

  // log("${ApiUrlConstants.syncCallLogs} ${jsonEncode(body)}");

  var request = http.Request('POST', Uri.parse(ApiUrlConstants.syncCallLogs));
  request.body = json.encode({"call_log": body});
  request.headers.addAll(await ApiUrlConstants.headers());

  // for (int i = 0; i < callLogs.length; i++) {
  //   var log = callLogs[i];
  //   body.add(<String, String>{
  //     'call_log[$i][simdisplayname]': log.simDisplayName ?? "",
  //     'call_log[$i][phoneaccountid]': log.phoneAccountId ?? "",
  //     'call_log[$i][name]': log.name ?? "",
  //     'call_log[$i][country_code]':
  //         log.number?.separatePhoneAndPhoneCode().phoneCode ?? "",
  //     'call_log[$i][mobile_no]': log.number
  //             ?.separatePhoneAndPhoneCode()
  //             .phone
  //             .replaceAll(AppConstants.specialCharAndSpaceRegex, "") ??
  //         "",
  //     'call_log[$i][call_type]': log.callType?.name ?? "",
  //     'call_log[$i][call_time]':
  //         log.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
  //     'call_log[$i][call_duration]': log.duration.toString(),
  //     'call_log[$i][call_duration_unit]': '1' //1 sec 2 min 3 horus
  //   });
  // }

  // log("sync call log ${jsonEncode(body)}");

  // var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //       ApiUrlConstants.syncCallLogs,
  //     ));

  // request.headers.addAll(await ApiUrlConstants.headers());
  // for (var field in body) {
  //   request.fields.addAll(field);
  // }

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    handleException(jsonData);
    // log(jsonEncode(jsonData));
    log("Call Log Synced");
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
