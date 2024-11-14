import 'dart:convert';

import 'package:spam_delection_app/models/country_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:http/http.dart' as http;

Future<CountriesResponse> getCountries() async {
  // String? deviceToken = await getDeviceToken();
  // String deviceType = getDeviceType();

  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointCountriesList),
    headers: <String, String>{
      // 'Content-Type': 'application/json',
      "X-API-KEY": ApiKeyConstants.apiKey,
    },
  );
  // print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CountriesResponse.fromJson(jsonData);
  } else {
    throw Exception('Failed to load countries');
  }
}