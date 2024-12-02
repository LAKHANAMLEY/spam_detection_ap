
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../../models/common_response_model.dart';

Future<CommonResponse> getCallLog() async {
  print(await ApiUrlConstants.headers());
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointgetCallLogList),
    headers: await ApiUrlConstants.headers(),
    body: {"phone": ""},
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}