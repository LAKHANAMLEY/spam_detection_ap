import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/call_type_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<CallTypeResponse> getCallTypes() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointCallType),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CallTypeResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}