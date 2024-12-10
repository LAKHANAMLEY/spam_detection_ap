import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> staffEditMember({required StaffMember staffMember}) async {
  var body = {
    'first_name': staffMember.firstName ?? "",
    'last_name': staffMember.lastName ?? "",
    'position': staffMember.relation ?? "",
    // 'photo': staffMember.photo,//photo ko is request me send nhi kr skte //multipart req use krna hogi
    'staff_id': staffMember.userId ?? "",
    'support_pin': staffMember.supportPin ?? "",
  };
  final request = http.MultipartRequest(
      "POST", Uri.parse(ApiUrlConstants.endPointStaffEditMember));
  request.headers.addAll(await ApiUrlConstants.headers());
  request.fields.addAll(body);
  if (staffMember.photoFile != null &&
      staffMember.photoFile?.mimeType != "http") {
    request.files.add(await http.MultipartFile.fromPath(
        "photo", staffMember.photoFile?.path ?? ""));
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
