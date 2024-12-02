import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<EnabledNotificationResponse> enableNotification({
  required String notificationOne,
  required String notificationReceive,
  required String notificationPush,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointEnabledDisabaled),
    headers: await ApiUrlConstants.headers(),
    body: {
      'notifications_list[0][notification_type_id]': notificationOne,
      'notifications_list[0][is_notification_receive]': notificationReceive,
      'notifications_list[0][is_push_receive]': notificationPush,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return EnabledNotificationResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
