import 'dart:convert';

import 'package:spam_delection_app/models/corporate_login_model.dart';
import 'package:spam_delection_app/models/mark_spam_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';
import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart' as http;
//remove dl// model create nhi kiya abhi//sabhi api k liye model banane ki need nhi// yes sir actual abhi status same ho tab
//model usi api ka banaya jayega jiska data hm use kree
//remove spam ka only statuscode chahiye 200 401 201 to iske liye hmne common model banaya h ""Response""
Future<Response> removeSpam({
  required String contactId,
}) async {
  var body = {
    'contacts_id': contactId,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointRemoveMarkSpam),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  //api work nahi kr rhi qki endpoint wrong h
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
