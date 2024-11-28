import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<Response> getUserProfile() async {
  var userId = await SharedPref.getUserId();
  final response = await http.get(
    Uri.parse("${ApiUrlConstants.getUserDetails}$userId"),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
