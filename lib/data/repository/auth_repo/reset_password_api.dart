import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ResetResponse> resetPassword(
    {required String email,
    required String code,
    required String password,
    required String confirmpassword}) async {
  var body = {
    'email': email,
    'code': code,
    'password': password,
    'confirm_password': confirmpassword,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointResetPassword),
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
