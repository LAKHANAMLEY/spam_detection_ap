import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> smsSeen({required String id}) async {
  var body = {
    '_id': id,
  };
  final response = await http.post(
    Uri.parse(ApiUrlConstants.smsSeen),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
