// import 'package:spam_delection_app/utils/get_device_token.dart';
import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ForgotResponse> forgotPassword({required String email}) async {
  // String? deviceToken = await getDeviceToken();
  // String deviceType = getDeviceType();

  var body = {
    'email': email,
  };
//karo login
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointForgotPassword),
    headers: <String, String>{
      // 'Content-Type': 'application/json',
      "X-API-KEY": ApiKeyConstants.apiKey,
    },
    body: body,
  );
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return ForgotResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
