import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<ContactListResponse> syncContacts(List<Contact> contacts) async {
  var headers = await ApiUrlConstants.headers();
  // var request =
  //     http.MultipartRequest('POST', Uri.parse(ApiUrlConstants.syncContacts));
  var request = http.Request('POST', Uri.parse(ApiUrlConstants.syncContacts));

  var contactsList = [];
  for (int i = 0; i < contacts.length; i++) {
    var contact = contacts[i];
    contactsList.add(
      {
        "phone": contact.phones.isNotEmpty
            ? contact.phones.first.number
                .separatePhoneAndPhoneCode()
                .phone
                .replaceAll(AppConstants.specialCharAndSpaceRegex, "")
            : "",
        "name": contact.displayName,
        "country_code": contact.phones.isNotEmpty
            ? contact.phones.first.number
                    .separatePhoneAndPhoneCode()
                    .phoneCode ??
                ""
            : "",
        "email": contact.emails.isNotEmpty ? contact.emails.first.address : "",
        "number_type":
            contact.phones.isNotEmpty ? contact.phones.first.label : ""
      },
    );
  }

  request.body = json.encode({"contacts_list": contactsList});

  // request.body = json.encode({
  //   "contacts_list": [
  //     {
  //       "phone": "7410268969",
  //       "name": "riya sen",
  //       "country_code": "+91",
  //       "email": "riya@gmail.com",
  //       "number_type": "OFFICE"
  //     },
  //     {
  //       "phone": "7410268968",
  //       "name": "raghav",
  //       "country_code": "+91",
  //       "email": "rahgav@gmail.com",
  //       "number_type": "HOME"
  //     }
  //   ]
  // });

//   for (int i = 0; i < contacts.length; i++) {
//     // var imageUint8List = await FastContacts.getContactImage(contacts[i].id);
//     // request.files.add(http.MultipartFile.fromBytes(
//     //     "contacts_list[$i][image]", imageUint8List?.toList() ?? []));
//     request.fields["contacts_list[$i][phone]"] = contacts[i].phones.isNotEmpty
//         ? contacts[i]
//             .phones
//             .first
//             .number
//             .separatePhoneAndPhoneCode()
//             .phone
//             .replaceAll(AppConstants.specialCharAndSpaceRegex, "")
//         : "";
//     request.fields["contacts_list[$i][number_type]"] =
//         contacts[i].phones.isNotEmpty ? contacts[i].phones.first.label : "";
//     request.fields["contacts_list[$i][name]"] = contacts[i].displayName;
//     request.fields["contacts_list[$i][country_code]"] =
//         contacts[i].phones.isNotEmpty
//             ? contacts[i]
//                     .phones
//                     .first
//                     .number
//                     .separatePhoneAndPhoneCode()
//                     .phoneCode ??
//                 ""
//             : "";
//     request.fields["contacts_list[$i][email]"] =
//         contacts[i].emails.isNotEmpty ? contacts[i].emails.first.address : "";
// //organization
//     // request.fields["contacts_list[$i][organization][company]"] =
//     //     contacts[i].emails.isNotEmpty
//     //         ? contacts[i].organization?.company ?? ""
//     //         : "";
//     // request.fields["contacts_list[$i][organization][department]"] =
//     //     contacts[i].emails.isNotEmpty
//     //         ? contacts[i].organization?.department ?? ""
//     //         : "";
//     // request.fields["contacts_list[$i][organization][jobDescription]"] =
//     //     contacts[i].emails.isNotEmpty
//     //         ? contacts[i].organization?.jobDescription ?? ""
//     //         : "";
//   }

  // log(request.body);

  request.headers.addAll(headers);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    log("Contact Synced");
    return ContactListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
