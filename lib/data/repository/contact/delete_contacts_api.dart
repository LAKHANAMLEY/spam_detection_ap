import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> deleteContact({
  required String contactid,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointDeleteContacts),
    headers: await ApiUrlConstants.headers(),
    body: {
      'contacts_id': contactid,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
