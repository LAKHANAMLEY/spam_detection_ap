import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> removeSpamSms({
  required String address,
}) async {
  var body = {
    // 'contacts_id': contactId,
    "address": address,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.removeSpamSms),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
