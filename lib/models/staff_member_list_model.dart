// To parse this JSON data, do
//
//     final staffMemberListResponse = staffMemberListResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

StaffMemberListResponse staffMemberListResponseFromJson(String str) =>
    StaffMemberListResponse.fromJson(json.decode(str));

String staffMemberListResponseToJson(StaffMemberListResponse data) =>
    json.encode(data.toJson());

class StaffMemberListResponse {
  final int? statusCode;
  final List<StaffMember>? staffmemberslist;

  StaffMemberListResponse({
    this.statusCode,
    this.staffmemberslist,
  });

  factory StaffMemberListResponse.fromJson(Map<String, dynamic> json) =>
      StaffMemberListResponse(
        statusCode: json["status_code"],
        staffmemberslist: json["staffmemberslist"] == null
            ? []
            : List<StaffMember>.from(
                json["staffmemberslist"]!.map((x) => StaffMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "staffmemberslist": staffmemberslist == null
            ? []
            : List<dynamic>.from(staffmemberslist!.map((x) => x.toJson())),
      };
}

class StaffMember {
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

  StaffMember({
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

  factory StaffMember.fromJson(Map<String, dynamic> json) => StaffMember(
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
