import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/common_response_model.dart';

Future<CommonResponse> unBlockContact({
  required String contactId,
  required String comment,

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointUnblockContacts),
    headers: await ApiUrlConstants.headers(),
    body: {
      'contacts_id': contactId,
      'comments': comment,

    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
