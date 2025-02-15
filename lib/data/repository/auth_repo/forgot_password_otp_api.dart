import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/forgot_password_otp_model.dart';

Future<ForgotPasswordPhoneResponse> forgotPasswordWithPhone(
    {required String phoneNumber, required String countryCode}) async {
  // String? deviceToken = await getDeviceToken();
  // String deviceType = getDeviceType();

  var body = {
    'phone': phoneNumber,
    'country_code': countryCode,
  };
  final response = await http.post(
    Uri.parse(ApiUrlConstants.forgotPasswordByOTP),
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
    return ForgotPasswordPhoneResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
