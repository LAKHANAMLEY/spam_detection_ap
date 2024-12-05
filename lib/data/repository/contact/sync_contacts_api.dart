import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ContactListResponse> syncContacts(List<Contact> contacts) async {
  var headers = await ApiUrlConstants.headers();
  var request =
      http.MultipartRequest('POST', Uri.parse(ApiUrlConstants.syncContacts));

  for (int i = 0; i < contacts.length; i++) {
    // var imageUint8List = await FastContacts.getContactImage(contacts[i].id);
    // request.files.add(http.MultipartFile.fromBytes(
    //     "contacts_list[$i][image]", imageUint8List?.toList() ?? []));
    request.fields["contacts_list[$i][phone]"] = contacts[i].phones.isNotEmpty
        ? contacts[i]
            .phones
            .first
            .number
            .separeatePhoneAndPhoneCode()
            .phone
            .replaceAll(AppConstants.specialCharAndSpaceRegex, "")
        : "";
    request.fields["contacts_list[$i][number_type]"] =
        contacts[i].phones.isNotEmpty ? contacts[i].phones.first.label : "";
    request.fields["contacts_list[$i][name]"] = contacts[i].displayName;
    request.fields["contacts_list[$i][country_code]"] =
        contacts[i].phones.isNotEmpty
            ? contacts[i]
                    .phones
                    .first
                    .number
                    .separeatePhoneAndPhoneCode()
                    .phoneCode ??
                ""
            : "";
    request.fields["contacts_list[$i][email]"] =
        contacts[i].emails.isNotEmpty ? contacts[i].emails.first.address : "";
  }

  request.headers.addAll(headers);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return ContactListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
