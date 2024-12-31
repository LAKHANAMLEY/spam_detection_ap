import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<CheckSpamNumberResponse> checkSpam({required CallLogData log}) async {
  // var log = callLogs;
  var body = {
    'is_manually': log.isManually, //0 for detail or 1 for broadcast
    'country_code': log.countryCode ?? "",
    'phone': log.mobileNo
            ?.separeatePhoneAndPhoneCode()
            .phone
            .replaceAll(AppConstants.specialCharAndSpaceRegex, "") ??
        "",
    'call_type': log.callType ?? "",
    'call_time': log.callTime?.toString().splitFirstBy(".") ?? "",
    'call_duration': log.callDuration ?? "",
    'call_duration_unit': '1' //1 sec 2 min 3 horus
  };

  print(jsonEncode(body));

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ApiUrlConstants.checkSpamContacts,
      ));

  request.headers.addAll(await ApiUrlConstants.headers());
  request.fields.addAll(body);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CheckSpamNumberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
