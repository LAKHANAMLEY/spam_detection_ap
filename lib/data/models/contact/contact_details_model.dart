// To parse this JSON data, do
//
//     final contactDetailsResponse = contactDetailsResponseFromJson(jsonString);
// To parse this JSON data, do
//
//     final contactDetailsResponse = contactDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'contact_list_response.dart';

ContactDetailsResponse contactDetailsResponseFromJson(String str) =>
    ContactDetailsResponse.fromJson(json.decode(str));

String contactDetailsResponseToJson(ContactDetailsResponse data) =>
    json.encode(data.toJson());

class ContactDetailsResponse {
  final int? statusCode;
  final ContactData? contactdetails;
  final String? message;

  ContactDetailsResponse({this.statusCode, this.contactdetails, this.message});

  factory ContactDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ContactDetailsResponse(
        statusCode: json["status_code"],
        contactdetails: json["contactdetails"] == null
            ? null
            : ContactData.fromJson(json["contactdetails"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "contactdetails": contactdetails?.toJson(),
      };
}

class Contactdetails {
  final String? id;
  final String? name;
  final String? countryCode;
  final String? mobileNo;
  final String? email;
  final String? numberType;
  final int? isSpam;
  final int? markspambyuser;
  final int? isBlocked;
  final String? spamReport;
  final String? callActivity;
  final String? usuallyCalls;
  final String? lastSeen;
  final int? isOnline;
  final String? isRegistered;
  final List<dynamic>? callHistory;

  Contactdetails({
    this.id,
    this.name,
    this.countryCode,
    this.mobileNo,
    this.email,
    this.numberType,
    this.isSpam,
    this.markspambyuser,
    this.isBlocked,
    this.spamReport,
    this.callActivity,
    this.usuallyCalls,
    this.lastSeen,
    this.isOnline,
    this.isRegistered,
    this.callHistory,
  });

  factory Contactdetails.fromJson(Map<String, dynamic> json) => Contactdetails(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        numberType: json["number_type"],
        isSpam: json["is_spam"],
        markspambyuser: json["markspambyuser"],
        isBlocked: json["is_blocked"],
        spamReport: json["spam_report"],
        callActivity: json["call_activity"],
        usuallyCalls: json["usually_calls"],
        lastSeen: json["last_seen"],
        isOnline: json["is_online"],
        isRegistered: json["is_registered"],
        callHistory: json["call_history"] == null
            ? []
            : List<dynamic>.from(json["call_history"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "mobile_no": mobileNo,
        "email": email,
        "number_type": numberType,
        "is_spam": isSpam,
        "markspambyuser": markspambyuser,
        "is_blocked": isBlocked,
        "spam_report": spamReport,
        "call_activity": callActivity,
        "usually_calls": usuallyCalls,
        "last_seen": lastSeen,
        "is_online": isOnline,
        "is_registered": isRegistered,
        "call_history": callHistory == null
            ? []
            : List<dynamic>.from(callHistory!.map((x) => x)),
      };
}

// import 'package:spam_delection_app/lib.dart';
//
// ContactDetailsResponse contactDetailsResponseFromJson(String str) =>
//     ContactDetailsResponse.fromJson(json.decode(str));
//
// String contactDetailsResponseToJson(ContactDetailsResponse data) =>
//     json.encode(data.toJson());
//
// class ContactDetailsResponse {
//   final int? statusCode;
//   final String? message;
//   final ContactData? contactdetails;
//
//   ContactDetailsResponse({
//     this.statusCode,
//     this.message,
//     this.contactdetails,
//   });
//
//   ContactDetailsResponse copyWith({
//     int? statusCode,
//     String? message,
//     ContactData? contactdetails,
//   }) =>
//       ContactDetailsResponse(
//         statusCode: statusCode ?? this.statusCode,
//         message: message ?? this.message,
//         contactdetails: contactdetails ?? this.contactdetails,
//       );
//
//   factory ContactDetailsResponse.fromJson(Map<String, dynamic> json) =>
//       ContactDetailsResponse(
//         statusCode: json["status_code"],
//         message: json["message"],
//         contactdetails: json["contactdetails"] == null
//             ? null
//             : ContactData.fromJson(json["contactdetails"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status_code": statusCode,
//         "message": message,
//         "contactdetails": contactdetails?.toJson(),
//       };
// }
