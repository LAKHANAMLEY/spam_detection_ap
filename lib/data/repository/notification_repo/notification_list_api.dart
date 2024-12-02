import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/enabled_disabled_notification_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';
import '../../../models/notification_list_model.dart';

Future<NotificationResponse> notificationList({
 // required String notificationOne,
 // required String notificationReceive,
  required String notificationPush,

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointNotificationList),
    headers: await ApiUrlConstants.headers(),
    body: {
      //
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return NotificationResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
