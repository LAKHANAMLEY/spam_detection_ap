// To parse this JSON data, do
//
//     final familyMemberDetailsResponse = familyMemberDetailsResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

FamilyMemberDetailsResponse familyMemberDetailsResponseFromJson(String str) =>
    FamilyMemberDetailsResponse.fromJson(json.decode(str));

String familyMemberDetailsResponseToJson(FamilyMemberDetailsResponse data) =>
    json.encode(data.toJson());

class FamilyMemberDetailsResponse {
  final int? statusCode;
  final FamilyMember? familymemberdetails;
  final String? message;

  FamilyMemberDetailsResponse({
    this.statusCode,
    this.familymemberdetails,
    this.message,
  });

  factory FamilyMemberDetailsResponse.fromJson(Map<String, dynamic> json) =>
      FamilyMemberDetailsResponse(
          statusCode: json["status_code"],
          familymemberdetails: json["familymemberdetails"] == null
              ? null
              : FamilyMember.fromJson(json["familymemberdetails"]),
          message: json["message"]);

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "familymemberdetails": familymemberdetails?.toJson(),
        "message": message,
      };
}
