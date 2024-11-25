import 'dart:convert';

import 'package:spam_delection_app/models/block_contacts_list_model.dart';
import 'package:spam_delection_app/models/country_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:http/http.dart' as http;

Future<BlockedContactListResponse> blockContact() async {
  // String? deviceToken = await getDeviceToken();
  // String deviceType = getDeviceType();

  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointBlockContactsList),
    headers: <String, String>{
      //"Authorization":'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzIxNjk2MjUsImV4cCI6MTczNzM1MzYyNSwiZGF0YSI6eyJ1X2lkIjoiNjcifX0.rSGnHIqJ_JSHlCGnEKjo86-DbXbqTqjCzclljMDg9To',
      // 'Content-Type': 'application/json',
      "X-API-KEY": ApiKeyConstants.apiKey,

    },
  );
  // print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return BlockedContactListResponse.fromJson(jsonData);
  } else {
    throw Exception('Failed to load Blocked Contacts');
  }
}