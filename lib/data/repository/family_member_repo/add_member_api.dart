import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/add_contact_model.dart';
import 'package:spam_delection_app/models/add_member_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';

Future<FamilyMemberAddResponse> familyaddMember({
  required String firstname,
  required String lastname,
  required String email,
  required String password,
  required relation,
  required supportpin,
  required phone,
  required countrycode

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyAddMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'password': password,
      'relation': relation,
      'support_pin': supportpin,
      'phone': phone,
      'country_code': countrycode

    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyMemberAddResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
