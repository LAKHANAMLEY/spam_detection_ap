// To parse this JSON data, do
//
//     final checkSpamNumberResponse = checkSpamNumberResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

CheckSpamNumberResponse checkSpamNumberResponseFromJson(String str) =>
    CheckSpamNumberResponse.fromJson(json.decode(str));

String checkSpamNumberResponseToJson(CheckSpamNumberResponse data) =>
    json.encode(data.toJson());

class CheckSpamNumberResponse {
  final int? statusCode;
  final ContactData? phonespamdetails;
  final String? message;

  CheckSpamNumberResponse({
    this.statusCode,
    this.phonespamdetails,
    this.message,
  });

  factory CheckSpamNumberResponse.fromJson(Map<String, dynamic> json) =>
      CheckSpamNumberResponse(
          statusCode: json["status_code"],
          phonespamdetails: json["phonespamdetails"] == null
              ? null
              : ContactData.fromJson(json["phonespamdetails"]),
          message: json["message"]);

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "phonespamdetails": phonespamdetails?.toJson(),
        "message": message,
      };
}

// class Phonespamdetails {
//   final String? name;
//   final String? mobileNo;
//   final String? isSpam;
//   final String? category;
//   final int? markspambyuser;

//   Phonespamdetails({
//     this.name,
//     this.mobileNo,
//     this.isSpam,
//     this.category,
//     this.markspambyuser,
//   });

//   factory Phonespamdetails.fromJson(Map<String, dynamic> json) =>
//       Phonespamdetails(
//         name: json["name"],
//         mobileNo: json["mobile_no"],
//         isSpam: json["is_spam"],
//         category: json["category"],
//         markspambyuser: json["markspambyuser"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "mobile_no": mobileNo,
//         "is_spam": isSpam,
//         "category": category,
//         "markspambyuser": markspambyuser,
//       };
// }
