import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/add_contact_model.dart';
import 'package:spam_delection_app/models/add_member_model.dart';
import 'package:spam_delection_app/models/family_edit_member_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';

Future<FamilyEditMemberResponse> familyEditMember({
  required String firstname,
  required String lastname,
  required familyId,
  required relation,
  required supportpin,


}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': firstname,
      'last_name': lastname,
      'relation': relation,
      'family_id': familyId,
      'support_pin': supportpin

    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyEditMemberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
