import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/sync_call_manually_model.dart';

Future<SyncCallManuallyResponse> syncCallLogManually(
    {required List<CallLogEntry> callLogs}) async {
  var body = [];
  for (int i = 0; i < callLogs.length; i++) {
    var log = callLogs[i];
    body.add(<String, String>{
      'simdisplayname': log.simDisplayName ?? "",
      'phoneaccountid': log.phoneAccountId ?? "",
      'name': log.name ?? "",
      'country_code': log.number?.separeatePhoneAndPhoneCode().phoneCode ?? "",
      'mobile_no': log.number
              ?.separeatePhoneAndPhoneCode()
              .phone
              .replaceAll(AppConstants.specialCharAndSpaceRegex, "") ??
          "",
      'call_type': log.callType?.name ?? "",
      'call_time':
          log.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
      'call_duration': log.duration.toString(),
      'call_duration_unit': '1' //1 sec 2 min 3 horus
    });
  }

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ApiUrlConstants.endPointSyncCallLogManually,
      ));

  request.headers.addAll(await ApiUrlConstants.headers());
  for (var field in body) {
    request.fields.addAll(field);
  }

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return SyncCallManuallyResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
