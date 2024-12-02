import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<LoginResponse> login(
    {required String email, required String password}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body = {
    'email': email,
    'password': password,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
    'user_role': "user"
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointEmailPassword),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return LoginResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
