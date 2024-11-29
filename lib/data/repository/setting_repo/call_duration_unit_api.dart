import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/call_duration_model.dart';
import 'package:spam_delection_app/models/country_list_model.dart';
import 'package:spam_delection_app/models/family_member_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<CallDurationResponse> getCallDuration() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointCallDurationUnit),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CallDurationResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}