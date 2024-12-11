import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<NotificationResponse> notificationList() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointNotificationList),
    headers: await ApiUrlConstants.headers(),
    //body: {},
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return NotificationResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
