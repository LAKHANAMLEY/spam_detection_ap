import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<FamilyMemberAddResponse> familyAddMember({
  required String firstname,
  required String lastname,
  required String email,
  required String password,
  required String relation,
  required String supportPin,
  required String phone,
  required String countryCode,
  XFile? photoFile,
}) async {
  var body = {
    'first_name': firstname,
    'last_name': lastname,
    'email': email,
    'password': password,
    'relation': relation,
    'support_pin': supportPin,
    'phone': phone,
    'country_code': countryCode
  };
  // final response = await http.post(
  //   Uri.parse(ApiUrlConstants.endPointFamilyAddMember),
  //   headers: await ApiUrlConstants.headers(),
  //   body: body,
  // );

  final request =
      http.MultipartRequest("POST", Uri.parse(ApiUrlConstants.addFamilyMember));
  request.headers.addAll(await ApiUrlConstants.headers());
  request.fields.addAll(body);
  if (photoFile != null && photoFile.mimeType != "http") {
    request.files
        .add(await http.MultipartFile.fromPath("photo", photoFile.path));
  }
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return FamilyMemberAddResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
