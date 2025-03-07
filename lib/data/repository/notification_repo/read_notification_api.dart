import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> readNotification(String notificationId) async {
  var body = {'notification_id': notificationId};
  final response = await http.post(Uri.parse(ApiUrlConstants.readNotification),
      headers: await ApiUrlConstants.headers(), body: body);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
