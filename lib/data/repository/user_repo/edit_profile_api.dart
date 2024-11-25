import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/change_security_pin_model.dart';
import 'package:spam_delection_app/models/edit_profile_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<EditProfileResponse> editProfile({
  required String firstname,
  required String lastname,
  required String dateofbirth,
  required String gender,
  required String state,
  required String city,
  required String zip,
  required String addressFirst,
  required String addressSecond,
  required String photo,

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointEditProfile),
    headers: await ApiUrlConstants.headers(),
    body: {
      "first_name": firstname,
      "last_name": lastname,
      "dob": dateofbirth,
      "gender": gender,
      'state':state,
      'city':city,
      'zip':zip,
      'address':addressFirst,
      'address2':addressSecond,
      'photo':photo,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return EditProfileResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
