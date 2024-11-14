import 'dart:convert';

import 'package:spam_delection_app/models/sign_up_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_constants/user_model.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart'as http;

Future<SignUpResponse> signup({required String email, required String password,required String firstname,required String lastname,required String dateofbirth, required phonenumber,required countrycode}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body ={
    'email': email,
    'password': password,
    'phone':phonenumber,
    'first_name':firstname,
    'last_name':lastname,
    'dob':dateofbirth,
    'country_code':countrycode,//signup kro//working // or kuch jo samajh nhi aa hra? //wait ab firebase se otp nhi aarha hai // phle aa rha tha?
    'device_token': deviceToken ?? '',// manually add kr rhe hai to ho rha hai but phone per otp nahi aarha ek baar check kr lena pls// ok for now leave it next api implement kro time nhi h
    'device_type': deviceType,//okay sir forgot password pe work kr rha hu // ok do it
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
