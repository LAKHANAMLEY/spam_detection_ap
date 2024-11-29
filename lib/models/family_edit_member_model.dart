// To parse this JSON data, do
//
//     final familyEditMemberResponse = familyEditMemberResponseFromJson(jsonString);

import 'dart:convert';

FamilyEditMemberResponse familyEditMemberResponseFromJson(String str) => FamilyEditMemberResponse.fromJson(json.decode(str));

String familyEditMemberResponseToJson(FamilyEditMemberResponse data) => json.encode(data.toJson());

class FamilyEditMemberResponse {
  final int? statusCode;
  final String? message;

  FamilyEditMemberResponse({
    this.statusCode,
    this.message,
  });

  factory FamilyEditMemberResponse.fromJson(Map<String, dynamic> json) => FamilyEditMemberResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
