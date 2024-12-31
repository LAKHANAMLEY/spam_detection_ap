import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<Response> corporateEditProfile({
  required CorporateData? user,
}) async {
  final body = {
    "corporate_name": user?.uName ?? "",
    "company": user?.company ?? "",
    "crn": user?.crn ?? "",
    //'photo':user?.photo??"",
  };

  var request = http.MultipartRequest(
    "POST",
    Uri.parse(ApiUrlConstants.editCorporateProfile),
  );

  request.headers.addAll(await ApiUrlConstants.headers());
  request.fields.addAll(body);
  //request.fields.addAll(body);
  var photo = user?.photoFile;
  if (photo != null && photo.path.isNotEmpty) {
    if (photo.mimeType == "http") {
      request.fields["photo"] = photo.path;
    } else {
      request.files.add(await http.MultipartFile.fromPath("photo", photo.path));
    }
  }

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
