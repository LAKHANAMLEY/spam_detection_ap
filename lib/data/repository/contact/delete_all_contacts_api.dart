import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> deleteAllContact() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.deleteAllContacts),
    headers: await ApiUrlConstants.headers(),
    // body: {
    //   'contacts_id': contact.id,
    // },
  );
  if (response.statusCode == 200) {
    if (response.body.isEmpty) {
      return Response(
          statusCode: 200, message: 'Contacts deleted successfully');
    }
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
