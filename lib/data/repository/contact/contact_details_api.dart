import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> getContactDetail(String id) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.familyMemberDetails + id),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
