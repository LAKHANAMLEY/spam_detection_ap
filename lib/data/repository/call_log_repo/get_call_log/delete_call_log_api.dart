import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../../models/common_response_model.dart';
Future<CommonResponse> deleteContact({
  required callid,

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointDeleteCallLog),
    headers: await ApiUrlConstants.headers(),
    body: {
      'call_log_id': callid
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
