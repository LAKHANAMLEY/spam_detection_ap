// To parse this JSON data, do
//
//     final familyMemberListResponse = familyMemberListResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

FamilyMemberListResponse familyMemberListResponseFromJson(String str) =>
    FamilyMemberListResponse.fromJson(json.decode(str));

String familyMemberListResponseToJson(FamilyMemberListResponse data) =>
    json.encode(data.toJson());

class FamilyMemberListResponse {
  final int? statusCode;
  final List<FamilyMember>? familymemberslist;

  FamilyMemberListResponse({
    this.statusCode,
    this.familymemberslist,
  });

  factory FamilyMemberListResponse.fromJson(Map<String, dynamic> json) =>
      FamilyMemberListResponse(
        statusCode: json["status_code"],
        familymemberslist: json["familymemberslist"] == null
            ? []
            : List<FamilyMember>.from(json["familymemberslist"]!
                .map((x) => FamilyMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "familymemberslist": familymemberslist == null
            ? []
            : List<dynamic>.from(familymemberslist!.map((x) => x.toJson())),
      };
}

class FamilyMember {
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
  final XFile? photoFile;

  FamilyMember({
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
    this.photoFile,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
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
