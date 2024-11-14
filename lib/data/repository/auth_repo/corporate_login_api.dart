import 'dart:convert';

import 'package:spam_delection_app/models/corporate_login_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart'as http;

Future<CorporateResponse> corporatelogin({required String email, required String password,required String corporateid}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body ={
    'corporate_id':corporateid,
    'email': email,
    'password': password,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
  };
//karo login
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointCorporateLogin),
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
    return CorporateResponse.fromJson(data);
  } else{
    throw Exception(response.body);
  }
}
