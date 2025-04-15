// import 'package:http/http.dart' as http;
// import 'package:spam_delection_app/lib.dart';
//
// Future<Response> editContact(
//     {required String fullName,
//     required String email,
//     required String numberType,
//     required String contactId,
//     required  String countryCode}) async {
//   final response = await http.post(
//     Uri.parse(ApiUrlConstants.editContacts),
//     headers: await ApiUrlConstants.headers(),
//     body: {
//       'name': fullName,
//       'country_code': countryCode,
//       'contacts_id': contactId,
//       'email': email,
//       'number_type': numberType,
//     },
//   );
//   if (response.statusCode == 200) {
//     var jsonData = json.decode(response.body);
//     return Response.fromJson(jsonData);
//   } else {
//     throw Exception(response.body);
//   }
// }
import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> editContact({
  required ContactData user,
  // required String fullName,
  // required String email,
  // required String numberType,
  // required phoneNumber,
  // required countryCode,
}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.editContacts),
    headers: await ApiUrlConstants.headers(),
    body: {
      'name': user.name,
      'email': user.email,
      'number_type': user.numberType,
      'country_code': user.countryCode,
      'phone': user.mobileNo,
      // 'contacts_id': user.id
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
