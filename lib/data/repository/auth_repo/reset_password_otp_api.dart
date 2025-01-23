import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ResetResponse> resetPasswordWithPhone(
    {required String phoneNumber,
    required String code,
    required String password,
    required String confirmPassword}) async {
  print(phoneNumber);
  var body = {
    'phone': phoneNumber,
    'code': code,
    'password': password,
    'confirm_password': confirmPassword,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.resetPassword),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return ResetResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
