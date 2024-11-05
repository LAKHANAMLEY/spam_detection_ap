import 'dart:convert';

import 'package:spam_delection_app/models/sign_up_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_constants/user_model.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart'as http;

Future<SignUpResponse> signup({required String email, required String password,required String firstname,required String lastname,required String dateofbirth, required phonenumber}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body ={
    'email': email,
    'password': password,
    'phone':phonenumber,
    'first_name':firstname,
    'last_name':lastname,
    'dob':dateofbirth,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
    'user_role': "user"
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointSignup),
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
    return SignUpResponse.fromJson(data);
  } else{
    throw Exception(response.body);
  }
}
