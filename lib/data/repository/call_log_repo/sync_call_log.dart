import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> syncCallLog({required List<CallLogEntry> callLogs}) async {
  var body = [];
  for (int i = 0; i < callLogs.length; i++) {
    var log = callLogs[i];
    body.add(<String, String>{
      'call_log[$i][simdisplayname]': log.simDisplayName ?? "",
      'call_log[$i][phoneaccountid]': log.phoneAccountId ?? "",
      'call_log[$i][name]': log.name ?? "",
      'call_log[$i][country_code]':
          log.number?.separeatePhoneAndPhoneCode().phoneCode ?? "",
      'call_log[$i][mobile_no]':
          log.number?.separeatePhoneAndPhoneCode().phone ?? "",
      'call_log[$i][call_type]': log.callType?.name ?? "",
      'call_log[$i][call_time]':
          log.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
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

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
