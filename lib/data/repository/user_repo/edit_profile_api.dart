import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<EditProfileResponse> editProfile({
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
  required User? user,
}) async {
  final body = {
    "first_name": user?.firstName ?? "",
    "last_name": user?.lastName ?? "",
    "dob": user?.dob?.toString() ?? "",
    "gender": user?.gender ?? "",
    'state': user?.state ?? "",
    'city': user?.city ?? "",
    'zip': user?.zip ?? "",
    'address': user?.address ?? "",
    'address2': user?.address2 ?? "",
    // 'photo': photo,
  };

  var request = http.MultipartRequest(
    "POST",
    Uri.parse(ApiUrlConstants.endPointEditProfile),
  );

  request.headers.addAll(await ApiUrlConstants.headers());
  request.fields.addAll(body);
  var photo = user?.photoFile;
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
    return EditProfileResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
