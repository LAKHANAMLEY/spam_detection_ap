import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/corporate_edit_profile_model.dart';

Future<Response> corporateEditProfile({
  // required String firstname,
  // required String lastname,
  // required String dateofbirth,
  // required String gender,
  // required String state,
  // required String city,
  // required String zip,
  // required String addressFirst,
  // required String addressSecond,
  // required XFile? photo,
  required CorporateData? user,
}) async {
  final body = {
    "UserName": user?.uName ?? "",
    "companyName": user?.company ?? "",
    "crnId": user?.crn ?? "",
    //'photo':user?.photo??"",
  };

  var request = http.MultipartRequest(
    "POST",
    Uri.parse(ApiUrlConstants.endPointCorporateEditProfile),
  );

  request.headers.addAll(await ApiUrlConstants.headers());
  //request.fields.addAll(body);
  var photo = user?.photo;
  if (photo != null && photo.path.isNotEmpty) {
    if (photo.mimeType == "http") {
      request.fields["photo"] = photo.path;
    } else {
      request.files.add(await http.MultipartFile.fromPath("photo", photo.path));
    }
  }

  print(body);
  // final response = await http.post(
  //   Uri.parse(ApiUrlConstants.endPointEditProfile),
  //   headers: await ApiUrlConstants.headers(),
  //   body: body,
  // );
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}

extension on String {
  get mimeType => null;

  get path => null;
}
