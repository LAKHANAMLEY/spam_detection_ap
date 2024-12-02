import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<CheckSpamNumberResponse> checkSpam({
  required phonenumber,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.addContact),
    headers: await ApiUrlConstants.headers(),
    body: {
      'phone': phonenumber,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CheckSpamNumberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
