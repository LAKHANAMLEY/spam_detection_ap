import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SignUpResponse> signup(
    {required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String dateofbirth,
    required phonenumber,
    required countrycode}) async {
  String? deviceToken = await getDeviceToken();
  String deviceType = getDeviceType();

  var body = {
    'email': email,
    'password': password,
    'phone': phonenumber,
    'first_name': firstname,
    'last_name': lastname,
    'dob': dateofbirth,
    'country_code': countrycode,
    'device_token': deviceToken ?? '',
    'device_type': deviceType,
    'user_role': "user"
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointSignup),
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
    return SignUpResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
