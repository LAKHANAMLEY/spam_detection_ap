import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/add_contact_model.dart';
import 'package:spam_delection_app/models/check_spam_number_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/change_password_model.dart';

Future<CheckSpamNumberResponse> checkSpam({

  required phonenumber,


}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointAddConstants),
    headers: await ApiUrlConstants.headers(),
    body: {
      'phone': phonenumber,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CheckSpamNumberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
