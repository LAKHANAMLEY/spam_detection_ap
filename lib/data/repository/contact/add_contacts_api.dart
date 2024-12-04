import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<AddContactResponse> addContact(
    {required String fullname,
    required String email,
    required String numbertype,
    required phonenumber,
    required countrycode}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.addContact),
    headers: await ApiUrlConstants.headers(),
    body: {
      'name': fullname,
      'email': email,
      'number_type': numbertype,
      'country_code': countrycode,
      'phone': phonenumber,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return AddContactResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}