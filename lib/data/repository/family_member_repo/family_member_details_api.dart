import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/common_response_model.dart';
import 'package:spam_delection_app/models/country_list_model.dart';
import 'package:spam_delection_app/models/family_member_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<CommonResponse> getFamilyDetail() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointFamilyMemberDetails),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}