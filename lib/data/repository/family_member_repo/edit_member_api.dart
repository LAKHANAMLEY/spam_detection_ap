import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<FamilyEditMemberResponse> familyEditMember({
  required String firstname,
  required String lastname,
  required familyId,
  required relation,
  required supportpin,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'first_name': firstname,
      'last_name': lastname,
      'relation': relation,
      'family_id': familyId,
      'support_pin': supportpin
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyEditMemberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
