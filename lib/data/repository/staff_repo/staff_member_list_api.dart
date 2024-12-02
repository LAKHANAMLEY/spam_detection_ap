import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<StaffMemberListResponse> getStaffList() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointStaffMemberList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return StaffMemberListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
