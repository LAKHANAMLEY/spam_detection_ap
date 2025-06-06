import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> sendVoipPush(String mobileNumber) async {
  var body = {
    "mode": "sandbox", //live
    "receiver_no": mobileNumber,
    "payload": {
      "aps": {
        "content-available": 1,
        "alert": {"title": "Incoming Call", "body": "John is calling you..."},
        "sound": "default"
      },
      "caller_name": "John",
      "call_id": mobileNumber,
      "type": "voip"
    }
  };
  final response = await http.post(
    Uri.parse(ApiUrlConstants.sendVoipPush),
    headers: await ApiUrlConstants.headers(),
    body: jsonEncode(body),
  );
  // log(ApiUrlConstants.getCallLogs);
  // log(jsonEncode(await ApiUrlConstants.headers()));
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
