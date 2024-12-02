import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/add_contact_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';
import '../../../models/common_response_model.dart';

Future<CommonResponse> editContact({
  required String fullname,
  required String email,
  required String numbertype,
  required contactid,
  required countrycode

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointAddConstants),
    headers: await ApiUrlConstants.headers(),
    body: {

      'name':  fullname,
      'country_code': countrycode,
      'contacts_id': contactid,
      'email': email,
      'number_type': numbertype,

    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
