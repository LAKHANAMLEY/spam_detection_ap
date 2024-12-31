import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> logout() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.logout),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
