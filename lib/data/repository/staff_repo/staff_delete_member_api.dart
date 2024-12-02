import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> staffDeleteMember({
  required staffId,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'staff_id': staffId,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
