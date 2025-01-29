import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<AddContactResponse> addContact({
  required ContactData contact,
  // required String fullName,
  // required String email,
  // required String numberType,
  // required phoneNumber,
  // required countryCode,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.addContact),
    headers: await ApiUrlConstants.headers(),
    body: {
      'name': contact.name,
      'email': contact.email,
      'number_type': contact.numberType,
      'country_code': contact.countryCode,
      'phone': contact.mobileNo,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return AddContactResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
