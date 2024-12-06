import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/family_member_details_model.dart';

Future<FamilyMemberDetailsResponse> getFamilyDetail(String id) async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointFamilyMemberDetails + id),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyMemberDetailsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
