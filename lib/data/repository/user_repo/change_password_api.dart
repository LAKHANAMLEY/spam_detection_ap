import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';

Future<ChangePasswordResponse> changePassword({
  required String currentPassword,
  required String newPassword,
  required String confirmNewPassword,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.changePassword),
    headers: await ApiUrlConstants.headers(),
    body: {
      "current_password": currentPassword,
      "new_password": newPassword,
      "confirm_new_password": confirmNewPassword,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ChangePasswordResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
