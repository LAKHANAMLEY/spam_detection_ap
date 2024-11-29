import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/common_response_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';

Future<CommonResponse> staffEditMember({
  required String firstname,
  required String lastname,
  required position,
  required supportpin,
  required photo,
  required staffId,


}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointStaffEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': firstname,
      'last_name': lastname,
      'position': position,
      'photo':photo,
      'staff_id':staffId,
      'support_pin': supportpin,


    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
