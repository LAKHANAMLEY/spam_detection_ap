import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> syncSmsWithServer({required List<SmsMessage> smsLogs}) async {
  var body = [];
  for (int i = 0; i < smsLogs.length; i++) {
    var sms = smsLogs[i];
    body.add(<String, String>{
      'address': sms.sender?.separatePhoneAndPhoneCode().phone ??
          "", //Check err if special message
      'body': sms.body ?? "",
      'country_code': sms.sender?.separatePhoneAndPhoneCode().phoneCode ?? "",
      'sendreceive_datetime': sms.dateSent?.toString().splitFirstBy(".") ?? "",
      'date': sms.date?.toString().splitFirstBy(".") ?? "",
      'is_read': sms.isRead.toString(),
      'thread_id': sms.threadId.toString(),
      '_id': sms.id.toString(),
      'MessageState': sms.state.name ?? "",
      'MessageKind': sms.kind?.name ?? "",
      'QueryKind': sms.kind?.name ?? "",
    });
    // body.add(<String, String>{
    //   'sms_list[$i][address]': sms.address ?? "",
    //   'sms_list[$i][body]': sms.body ?? "",
    //   'sms_list[$i][country_code]':
    //       sms.sender?.separatePhoneAndPhoneCode().phoneCode ?? "",
    //   'sms_list[$i][sendreceive_datetime]':
    //       sms.dateSent?.toString().splitFirstBy(".") ?? "",
    //   'sms_list[$i][date]': sms.date?.toString().splitFirstBy(".") ?? "",
    //   'sms_list[$i][is_read]': sms.isRead.toString(),
    //   'sms_list[$i][thread_id]': sms.threadId.toString(),
    //   'sms_list[$i][_id]': sms.id.toString(),
    //   'sms_list[$i][MessageState]': sms.state.name ?? "",
    //   'sms_list[$i][MessageKind]': sms.kind?.name ?? "",
    //   'sms_list[$i][QueryKind]': sms.kind?.name ?? "",
    // });
  }

  // log("${ApiUrlConstants.syncSms}: ${jsonEncode(body)}");

  // var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //       ApiUrlConstants.syncSms,
  //     ));

  var request = http.Request('POST', Uri.parse(ApiUrlConstants.syncSms));

  request.body = jsonEncode({"sms_list": body});

  request.headers.addAll(await ApiUrlConstants.headers());
  // for (var field in body) {
  //   request.fields.addAll(field);
  // }

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    // log(jsonEncode(jsonData));
    log("Sms Log Synced");

    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
