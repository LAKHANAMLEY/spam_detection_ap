import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> staffAddMember({
  required String firstname,
  required String lastname,
  required email,
  required password,
  required position,
  required supportpin,
  required phone,
  required countrycode,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointStaffAddMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'password': password,
      'position': position,
      'phone': phone,
      'country_code': countrycode,
      'support_pin': supportpin,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
