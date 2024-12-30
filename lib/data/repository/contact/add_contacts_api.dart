import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<AddContactResponse> addContact(
    {required String fullName,
    required String email,
    required String numberType,
    required phoneNumber,
    required countryCode}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.addContact),
    headers: await ApiUrlConstants.headers(),
    body: {
      'name': fullName,
      'email': email,
      'number_type': numberType,
      'country_code': countryCode,
      'phone': phoneNumber,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return AddContactResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
