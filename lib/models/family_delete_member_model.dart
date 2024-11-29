// To parse this JSON data, do
//
//     final familyDeleteMemberResponse = familyDeleteMemberResponseFromJson(jsonString);

import 'dart:convert';

FamilyDeleteMemberResponse familyDeleteMemberResponseFromJson(String str) => FamilyDeleteMemberResponse.fromJson(json.decode(str));

String familyDeleteMemberResponseToJson(FamilyDeleteMemberResponse data) => json.encode(data.toJson());

class FamilyDeleteMemberResponse {
  final int? statusCode;
  final String? message;

  FamilyDeleteMemberResponse({
    this.statusCode,
    this.message,
  });

  factory FamilyDeleteMemberResponse.fromJson(Map<String, dynamic> json) => FamilyDeleteMemberResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
