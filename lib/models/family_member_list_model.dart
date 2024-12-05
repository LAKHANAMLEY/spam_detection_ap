// To parse this JSON data, do
//
//     final familyMemberListResponse = familyMemberListResponseFromJson(jsonString);

import 'dart:convert';

FamilyMemberListResponse familyMemberListResponseFromJson(String str) => FamilyMemberListResponse.fromJson(json.decode(str));

String familyMemberListResponseToJson(FamilyMemberListResponse data) => json.encode(data.toJson());

class FamilyMemberListResponse {
  final int? statusCode;
  final List<FamilyData>? familymemberslist;

  FamilyMemberListResponse({
    this.statusCode,
    this.familymemberslist,
  });

  factory FamilyMemberListResponse.fromJson(Map<String, dynamic> json) => FamilyMemberListResponse(
    statusCode: json["status_code"],
    familymemberslist: json["familymemberslist"] == null ? [] : List<FamilyData>.from(json["familymemberslist"]!.map((x) => FamilyData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "familymemberslist": familymemberslist == null ? [] : List<dynamic>.from(familymemberslist!.map((x) => x.toJson())),
  };
}

class FamilyData {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? userRole;
  final String? photo;
  final String? relation;
  final String? supportPin;
  final String? countryCode;

  FamilyData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.userRole,
    this.photo,
    this.relation,
    this.supportPin,
    this.countryCode,
  });

  factory FamilyData.fromJson(Map<String, dynamic> json) => FamilyData(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    userRole: json["user_role"],
    photo: json["photo"],
    relation: json["relation"],
    supportPin: json["support_pin"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "user_role": userRole,
    "photo": photo,
    "relation": relation,
    "support_pin": supportPin,
    "country_code": countryCode,
  };
}
