import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/add_contact_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../../models/common_response_model.dart';
Future<CommonResponse> deleteAllContact({
  required callid,

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointDeleteAllCallLog),
    headers: await ApiUrlConstants.headers(),
    body: {
      //
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
