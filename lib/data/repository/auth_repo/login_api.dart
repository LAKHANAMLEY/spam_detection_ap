
import 'dart:convert';

import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_constants/user_model.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart'as http;

Future<LoginResponse> login({required String email, required String password}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body ={
    'email': email,
    'password': password,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
    'user_role': "user"
  };
//karo login
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointEmailPassword),
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
    return LoginResponse.fromJson(data);//ab krna login
  } else{
    throw Exception(response.body);
  }
}
