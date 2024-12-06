import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> editFamilyMember({required FamilyMember familyMember}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': familyMember.firstName,
      'last_name': familyMember.lastName,
      'relation': familyMember.relation,
      'family_id': familyMember.userId,
      'support_pin': familyMember.supportPin
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
