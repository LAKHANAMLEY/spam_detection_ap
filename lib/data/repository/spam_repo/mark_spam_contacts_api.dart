import 'dart:convert';

import 'package:spam_delection_app/models/corporate_login_model.dart';
import 'package:spam_delection_app/models/mark_spam_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart' as http;

Future<MarkSpamResponse> markSpam({
  required String contactId,
  required String comment,
  required String numberType,
  required String categoryId,
  required String phone,
}) async {
  var body = {
    'contacts_id': contactId,
    'comments': comment,
    'number_type': numberType,
    'category_id': categoryId,
    'phone': phone,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointMarkSpamContacts),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  //api work nahi kr rhi qki endpoint wrong h
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return MarkSpamResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
