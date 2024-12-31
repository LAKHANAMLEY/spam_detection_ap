import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> setUserOnlineOrOffline({required String isOnline}) async {
  var body = {
    'is_online': isOnline,
  };
  final response = await http.post(
    Uri.parse(ApiUrlConstants.setUserOnlineOffline),
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
