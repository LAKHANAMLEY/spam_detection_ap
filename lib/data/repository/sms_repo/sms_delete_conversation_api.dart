import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> deleteConversation({
  required address,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.smsDeleteConversation),
    headers: await ApiUrlConstants.headers(),
    body: {
      'address': address,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
