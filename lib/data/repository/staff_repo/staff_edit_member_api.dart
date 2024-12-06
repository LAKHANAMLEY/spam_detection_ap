import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> staffEditMember({required StaffMember staffMember}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointStaffEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': staffMember.firstName,
      'last_name': staffMember.lastName,
      'position': staffMember.relation,
      'photo': staffMember.photo,
      'staff_id': staffMember.userId,
      'support_pin': staffMember.supportPin,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
