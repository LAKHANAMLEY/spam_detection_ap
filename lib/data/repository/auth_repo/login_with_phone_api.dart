import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/user_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';

Future<LoginResponse> loginWithPhone(
    {required String countryCode, required String phone}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body = {
    'country_code': countryCode,
    'phone': phone,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointEmailPassword),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return LoginResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
