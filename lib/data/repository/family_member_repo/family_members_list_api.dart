import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/country_list_model.dart';
import 'package:spam_delection_app/models/family_member_list_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<FamilyMemberListResponse> getFamilyList() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointFamilyMembersList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyMemberListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}