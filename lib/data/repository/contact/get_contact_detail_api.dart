import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ContactDetailsResponse> getContactDetail(
    {required String mobileNo}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.contactDetail),
    headers: await ApiUrlConstants.headers(),
    body: {"mobile_no": mobileNo},
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ContactDetailsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
