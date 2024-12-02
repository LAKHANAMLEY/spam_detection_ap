import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ContactListResponse> getContacts() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.contactList),
    headers: await ApiUrlConstants.headers(),
    body: {"phone": ""},
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ContactListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
