import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SignUpResponse> socialSignUp({
  required String email,
  required String signupMethod,
  required String firstName,
  required String lastName,
}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();
  var body = {
    'email': email,
    'signup_method': signupMethod,
    'first_name': firstName,
    'last_name': lastName,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointSocialSignup),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return SignUpResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
