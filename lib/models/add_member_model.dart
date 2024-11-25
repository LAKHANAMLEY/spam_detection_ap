// To parse this JSON data, do
//
//     final familyMemberAddResponse = familyMemberAddResponseFromJson(jsonString);

import 'dart:convert';

FamilyMemberAddResponse familyMemberAddResponseFromJson(String str) => FamilyMemberAddResponse.fromJson(json.decode(str));

String familyMemberAddResponseToJson(FamilyMemberAddResponse data) => json.encode(data.toJson());

class FamilyMemberAddResponse {
  final int? statusCode;
  final String? message;

  FamilyMemberAddResponse({
    this.statusCode,
    this.message,
  });

  factory FamilyMemberAddResponse.fromJson(Map<String, dynamic> json) => FamilyMemberAddResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
