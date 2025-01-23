import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/sms_spam_list_model.dart';

Future<SmsSpamListResponse> smsSpamList() async {
  print(await ApiUrlConstants.headers());
  final response = await http.post(
    Uri.parse(ApiUrlConstants.smsSpamList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return SmsSpamListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
