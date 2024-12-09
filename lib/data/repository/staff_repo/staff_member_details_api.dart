import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<StaffMemberDetailsResponse> getStaffDetail(String id) async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointStaffMemberDetails + id),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return StaffMemberDetailsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
