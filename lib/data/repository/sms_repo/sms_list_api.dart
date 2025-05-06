import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SmsListResponse> smsList() async {
  var date = await SharedPref.getLastSyncDate();
  var body = {
    "lastsyncdate": date.toString().split(".").first,
  };
  log(jsonEncode(body));
  final response = await http.post(
    Uri.parse(ApiUrlConstants.smsList),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return SmsListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
