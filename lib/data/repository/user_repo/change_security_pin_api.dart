import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/change_security_pin_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<ChangeSecurityPinResponse> changeSecurityPin({
  required String currentPin,
  required String newPin,
  required String confirmNewPin,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointChangeSecurityPin),
    headers: await ApiUrlConstants.headers(),
    body: {
      "current_pin": currentPin,
      "new_pin": newPin,
      "confirm_new_pin": confirmNewPin,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ChangeSecurityPinResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
