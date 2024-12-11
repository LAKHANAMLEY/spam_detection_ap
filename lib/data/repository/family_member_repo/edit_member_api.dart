import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> familyEditMember({required FamilyMember familyMember}) async {
  var body = {
    'first_name': familyMember.firstName ?? "",
    'last_name': familyMember.lastName ?? "",
    'position': familyMember.relation ?? "",
    // 'photo': staffMember.photo,//photo ko is request me send nhi kr skte //multipart req use krna hogi
    'staff_id': familyMember.userId ?? "",
    'support_pin': familyMember.supportPin ?? "",
  };
  final request = http.MultipartRequest(
      "POST", Uri.parse(ApiUrlConstants.endPointFamilyEditMember));
  request.headers.addAll(await ApiUrlConstants.headers());
  request.fields.addAll(body);
  if (familyMember.photoFile != null &&
      familyMember.photoFile?.mimeType != "http") {
    request.files.add(await http.MultipartFile.fromPath(
        "photo", familyMember.photoFile?.path ?? ""));
  }
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  // final response = await http.post(
  //   Uri.parse(ApiUrlConstants.endPointStaffEditMember),
  //   headers: await ApiUrlConstants.headers(),
  //   body: body,
  // );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
