import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<NotificationListResponse> notificationList() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointNotificationList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return NotificationListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
