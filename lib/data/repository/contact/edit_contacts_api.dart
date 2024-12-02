import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> editContact(
    {required String fullname,
    required String email,
    required String numbertype,
    required contactid,
    required countrycode}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointEditContacts),
    headers: await ApiUrlConstants.headers(),
    body: {
      'name': fullname,
      'country_code': countrycode,
      'contacts_id': contactid,
      'email': email,
      'number_type': numbertype,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
