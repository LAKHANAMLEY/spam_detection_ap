import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<LoginResponse> loginWithPhone(
    {required String countryCode, required String phone}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body = {
    'country_code': countryCode,
    'phone': phone,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
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
