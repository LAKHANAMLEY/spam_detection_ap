// To parse this JSON data, do
//
//     final contactListResponse = contactListResponseFromJson(jsonString);

import 'dart:convert';

ContactListResponse contactListResponseFromJson(String str) =>
    ContactListResponse.fromJson(json.decode(str));

String contactListResponseToJson(ContactListResponse data) =>
    json.encode(data.toJson());

class ContactListResponse {
  final int? statusCode;
  final List<ContactData>? contactslist;
  final String? message;

  ContactListResponse({this.statusCode, this.contactslist, this.message});

  ContactListResponse copyWith({
    int? statusCode,
    List<ContactData>? contactslist,
  }) =>
      ContactListResponse(
        statusCode: statusCode ?? this.statusCode,
        contactslist: contactslist ?? this.contactslist,
      );

  factory ContactListResponse.fromJson(Map<String, dynamic> json) =>
      ContactListResponse(
        statusCode: json["status_code"],
        contactslist: json["contactslist"] == null
            ? []
            : List<ContactData>.from(
                json["contactslist"]!.map((x) => ContactData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "contactslist": contactslist == null
            ? []
            : List<dynamic>.from(contactslist!.map((x) => x.toJson())),
        "message": message
      };
}

class ContactData {
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
  final List<dynamic>? callHistory;

  ContactData({
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
    this.callHistory,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
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
        "call_history": callHistory == null
            ? []
            : List<dynamic>.from(callHistory!.map((x) => x)),
      };
}
