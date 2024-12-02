import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<NotificationTypeResponse> getcallDuration() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointNotificationType),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return NotificationTypeResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
