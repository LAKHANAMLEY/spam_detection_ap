// To parse this JSON data, do
//
//     final staffMemberDetailsResponse = staffMemberDetailsResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

StaffMemberDetailsResponse staffMemberDetailsResponseFromJson(String str) =>
    StaffMemberDetailsResponse.fromJson(json.decode(str));

String staffMemberDetailsResponseToJson(StaffMemberDetailsResponse data) =>
    json.encode(data.toJson());

class StaffMemberDetailsResponse {
  final int? statusCode;
  final StaffMember? staffmemberdetails;
  final String? message;

  StaffMemberDetailsResponse({
    this.statusCode,
    this.staffmemberdetails,
    this.message,
  });

  factory StaffMemberDetailsResponse.fromJson(Map<String, dynamic> json) =>
      StaffMemberDetailsResponse(
        statusCode: json["status_code"],
        staffmemberdetails: json["staffmemberdetails"] == null
            ? null
            : StaffMember.fromJson(json["staffmemberdetails"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "staffmemberdetails": staffmemberdetails?.toJson(),
        "message": message,
      };
}

class Staffmemberdetails {
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

  Staffmemberdetails({
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

  factory Staffmemberdetails.fromJson(Map<String, dynamic> json) =>
      Staffmemberdetails(
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
