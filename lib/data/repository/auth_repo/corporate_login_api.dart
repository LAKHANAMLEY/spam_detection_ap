import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/corporate_login_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';

Future<CorporateResponse> corporateLogin(
    {required String email,
    required String password,
    required String corporateid}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body = {
    'corporate_id': corporateid,
    'email': email,
    'password': password,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
  };
//karo login
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointCorporateLogin),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return CorporateResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
