import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SmsLogDetailsResponse> syncSmsDetailsWithServer({
  required List<SmsMessage> smsLogs,
  required String address,
}) async {
  var body = [];
  for (int i = 0; i < smsLogs.length; i++) {
    var sms = smsLogs[i];
    body.add(<String, String>{
      'address': sms.address?.separatePhoneAndPhoneCode().phone ??
          "", //Check err if special message
      'body': sms.body ?? "",
      'country_code': sms.address?.separatePhoneAndPhoneCode().phoneCode ?? "",
      'sendreceive_datetime': sms.date?.toString().splitFirstBy(".") ?? "",
      'date': (sms.date ?? DateTime.now()).toString().splitFirstBy("."),
      'is_read': sms.isRead ?? false ? "1" : "0",
      'thread_id': sms.threadId.toString(),
      '_id': sms.id.toString(),
      'MessageState': sms.state.name,
      'MessageKind': sms.kind?.name ?? "",
      'QueryKind': sms.kind?.name ?? "",
    });
  }

  var request = http.Request('POST', Uri.parse(ApiUrlConstants.syncSmsDetails));
  Map<String, dynamic> reqBody = {
    "address": address.separatePhoneAndPhoneCode().phone,
  };
  if (smsLogs.isNotEmpty) reqBody["sms_list_details"] = body;
  request.body = jsonEncode(reqBody);

  log("${ApiUrlConstants.syncSmsDetails}: ${(request.body)}");

  request.headers.addAll(await ApiUrlConstants.headers());
  // for (var field in body) {
  //   request.fields.addAll(field);
  // }

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    // log(jsonEncode(jsonData));
    log("Sms Log Details Synced");

    return SmsLogDetailsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
