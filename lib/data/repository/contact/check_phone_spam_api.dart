import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<CheckSpamNumberResponse> checkSpam({
  required List<CallLogEntry> callLogs,
}) async {
  List<Map<String, dynamic>> callLogData = callLogs
      .map((log) => {
            // 'is_manually': "1", //0 for detail or 1 for broadcast
            // 'country_code':
            //     log.number?.separatePhoneAndPhoneCode().phoneCode ?? "",
            // 'phone': log.number?.separatePhoneAndPhoneCode().phone ?? "",
            // 'call_type': log.callType?.name ?? "",
            // 'call_time':
            //     log.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
            // 'call_duration': log.duration ?? "",
            // 'call_duration_unit': '1', //1 sec 2 min 3 horus

            "simdisplayname": log.simDisplayName,
            "phoneaccountid": log.phoneAccountId,
            "name": log.name,
            "country_code": log.number?.separatePhoneAndPhoneCode().phoneCode,
            "mobile_no": log.number?.separatePhoneAndPhoneCode().phone,
            "call_type": log.callType?.name,
            "call_time":
                log.timestamp?.toDateTime().toString().splitFirstBy(".") ?? "",
            "call_duration": log.duration.toString(),
            "call_duration_unit": "1"
          })
      .toList();

  Map<String, dynamic> body = {
    "mobile_no": callLogs.first.number?.separatePhoneAndPhoneCode().phone ?? "",
  };
  if (callLogData.isNotEmpty) body["call_log"] = callLogData;

  // log("${ApiUrlConstants.checkSpamContacts} ${jsonEncode(body)}");

  // var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //       ApiUrlConstants.checkSpamContacts,
  //     ));

  var request =
      http.Request('POST', Uri.parse(ApiUrlConstants.checkSpamContacts));

  request.headers.addAll(await ApiUrlConstants.headers());
  request.body = jsonEncode(body);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CheckSpamNumberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
