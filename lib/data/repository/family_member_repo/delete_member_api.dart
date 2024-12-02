import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<FamilyDeleteMemberResponse> familyDeleteMember({
  required familyId,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'family_id': familyId,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyDeleteMemberResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
