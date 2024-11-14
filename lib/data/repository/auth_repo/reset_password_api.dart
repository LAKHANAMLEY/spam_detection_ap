import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/reset_password_models.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';

//yha v code h
Future<ResetResponse> resetPassword(
    {required String email,
    required String code,
    required String password,
    required String confirmpassword}) async {
  // String? deviceToken = await getDeviceToken();
  // String deviceType = getDeviceType();

  var body = {
    'email': email,
    'code': code,
    'password': password,
    'confirm_password': confirmpassword,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointResetPassword),
    headers: <String, String>{
      // 'Content-Type': 'application/json',
      "X-API-KEY": ApiKeyConstants.apiKey,
    },
    body: body,
  );
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return ResetResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
