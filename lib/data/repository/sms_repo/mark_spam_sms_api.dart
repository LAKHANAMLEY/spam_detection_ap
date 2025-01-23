import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> markSpamSms({
  required String address,
  required String comment,
  required String numberType,
  required String category,
}) async {
  var body = {
    'address': address,
    'category': category,
    'comments': comment,
    'number_type': numberType,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.markSpamSms),
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
