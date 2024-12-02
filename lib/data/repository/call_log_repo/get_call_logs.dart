import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/call_logs_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<CallLogsListResponse> getCallLogs() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.getCallLogs),
    headers: await ApiUrlConstants.headers(),
    body: {},
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CallLogsListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
