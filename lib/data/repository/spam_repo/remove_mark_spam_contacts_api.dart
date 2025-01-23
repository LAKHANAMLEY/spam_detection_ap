import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> removeSpam({
  required String contactId,
}) async {
  var body = {
    // 'contacts_id': contactId,
    'mobile_no': contactId,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.removeSpam),
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
