import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';

Future<ContactListResponse> getContacts() async {
  // String? deviceToken = await getDeviceToken();
  // String deviceType = getDeviceType();

  final response = await http
      .post(Uri.parse(ApiUrlConstants.contactList), headers: <String, String>{
    // 'Content-Type': 'application/json',
    "X-API-KEY": ApiKeyConstants.apiKey,
    "Authorization": await SharedPref.getToken()
  }, body: {
    "phone": ""
  });
  // print(body);
  print('response.body ${response.body}');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ContactListResponse.fromJson(jsonData);
  } else {
    throw Exception('Failed to load countries');
  }
}
