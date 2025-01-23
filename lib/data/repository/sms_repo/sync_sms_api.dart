import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> syncSms({required List<SmsMessage> smsLogs}) async {
  var body = [];
  for (int i = 0; i < smsLogs.length; i++) {
    var sms = smsLogs[i];
    body.add(<String, String>{
      'sms_list[$i][address]': sms.address ?? "",
      'sms_list[$i][body]': sms.body ?? "",
      'sms_list[$i][country_code]':
          sms.sender?.separatePhoneAndPhoneCode().phoneCode ?? "",
      'sms_list[$i][sendreceive_datetime]':
          sms.dateSent?.toString().splitFirstBy(".") ?? "",
      'sms_list[$i][date]': sms.date?.toString().splitFirstBy(".") ?? "",
      'sms_list[$i][is_read]': '0',
      'sms_list[$i][thread_id]': '123',
      'sms_list[0][_id]': '12',
      'sms_list[0][MessageState]': sms.state.name ?? "",
      'sms_list[0][MessageKind]': sms.kind?.name ?? "",
      'sms_list[0][QueryKind]': sms.kind?.name ?? "",
    });
  }

  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ApiUrlConstants.syncSms,
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
