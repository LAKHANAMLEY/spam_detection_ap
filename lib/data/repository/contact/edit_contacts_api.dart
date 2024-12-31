import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> editContact(
    {required String fullName,
    required String email,
    required String numberType,
    required contactId,
    required countryCode}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.editContacts),
    headers: await ApiUrlConstants.headers(),
    body: {
      'name': fullName,
      'country_code': countryCode,
      'contacts_id': contactId,
      'email': email,
      'number_type': numberType,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
