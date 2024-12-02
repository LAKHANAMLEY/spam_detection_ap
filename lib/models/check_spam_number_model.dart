// To parse this JSON data, do
//
//     final checkSpamNumberResponse = checkSpamNumberResponseFromJson(jsonString);

import 'dart:convert';

CheckSpamNumberResponse checkSpamNumberResponseFromJson(String str) => CheckSpamNumberResponse.fromJson(json.decode(str));

String checkSpamNumberResponseToJson(CheckSpamNumberResponse data) => json.encode(data.toJson());

class CheckSpamNumberResponse {
  final int? statusCode;
  final Phonespamdetails? phonespamdetails;

  CheckSpamNumberResponse({
    this.statusCode,
    this.phonespamdetails,
  });

  factory CheckSpamNumberResponse.fromJson(Map<String, dynamic> json) => CheckSpamNumberResponse(
    statusCode: json["status_code"],
    phonespamdetails: json["phonespamdetails"] == null ? null : Phonespamdetails.fromJson(json["phonespamdetails"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "phonespamdetails": phonespamdetails?.toJson(),
  };
}

class Phonespamdetails {
  final String? name;
  final String? mobileNo;
  final int? isSpam;
  final int? markspambyuser;

  Phonespamdetails({
    this.name,
    this.mobileNo,
    this.isSpam,
    this.markspambyuser,
  });

  factory Phonespamdetails.fromJson(Map<String, dynamic> json) => Phonespamdetails(
    name: json["name"],
    mobileNo: json["mobile_no"],
    isSpam: json["is_spam"],
    markspambyuser: json["markspambyuser"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_no": mobileNo,
    "is_spam": isSpam,
    "markspambyuser": markspambyuser,
  };
}
