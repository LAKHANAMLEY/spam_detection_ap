import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

Future<ContactListResponse> getContacts() async {
  print(await ApiUrlConstants.headers());
  final response = await http.post(
    Uri.parse(ApiUrlConstants.contactList),
    headers: await ApiUrlConstants.headers(),
    body: {"phone": ""},
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ContactListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
