import 'dart:convert';

import 'package:call_e_log/call_log.dart';
import 'package:http/http.dart' as http;
import 'package:spam_delection_app/extensions/timestamp_ext.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<Response> syncCallLog({required List<CallLogEntry> callLogs}) async {
  var body = [];
  for (int i = 0; i < callLogs.length; i++) {
    var log = callLogs[i];
    body.add(<String, String>{
      'call_log[$i][simdisplayname]': log.simDisplayName ?? "",
      'call_log[$i][phoneaccountid]': log.phoneAccountId ?? "",
      'call_log[$i][name]': log.name ?? "",
      'call_log[$i][mobile_no]': log.number ?? "",
      'call_log[$i][call_type]': log.callType.toString(),
      'call_log[$i][call_time]': log.timestamp?.toDateTime().toString() ?? "",
      'call_log[$i][call_duration]': log.duration.toString(),
      'call_log[$i][call_duration_unit]': '1' //1 sec 2 min 3 horus
    });
  }

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ApiUrlConstants.syncCallLogs,
      ));

  request.headers.addAll(await ApiUrlConstants.headers());
  for (var field in body) {
    request.fields.addAll(field);
  }

  // var body = callLogs.map((e) => <String, dynamic>{}).toList();
  // final response = await http.post(
  //   Uri.parse(ApiUrlConstants.syncCallLogs),
  //   headers: await ApiUrlConstants.headers(),
  //   body: jsonEncode(body),
  // );

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
