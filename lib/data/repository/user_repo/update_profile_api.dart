import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<UpdateProfileResponse> updateProfile({
  required String firstname,
  required String lastname,
  required String dateofbirth,
  required String gender,
  required String state,
  required String city,
  required String zip,
  required String addressFirst,
  required String addressSecond,
  required String photo,
  required String username,
  required String countryid,
  required String supportpin,
  required String confirmsupportpin,
  required String password,
  required String confirmpassword,
  required String phoneNumber,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointUpdateProfile),
    headers: await ApiUrlConstants.headers(),
    body: {
      "first_name": firstname,
      "last_name": lastname,
      "dob": dateofbirth,
      "user_name": username,
      "country_id": countryid,
      "support_pin": supportpin,
      "confirm_support_pin": confirmsupportpin,
      "password": password,
      "confirm_password": confirmpassword,
      "gender": gender,
      'state': state,
      'city': city,
      'zip': zip,
      'address': addressFirst,
      'address2': addressSecond,
      'photo': photo,
      'phone': phoneNumber,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return UpdateProfileResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
