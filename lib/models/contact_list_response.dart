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
  final int? isBlocked;
  final int? markSpamByUser;

  ContactData({
    this.id,
    this.name,
    this.countryCode,
    this.mobileNo,
    this.email,
    this.numberType,
    this.isSpam,
    this.isBlocked,
    this.markSpamByUser,
  });

  ContactData copyWith({
    String? id,
    String? name,
    String? countryCode,
    String? mobileNo,
    String? email,
    String? numberType,
    int? isSpam,
    int? isBlocked,
    int? markSpamByUser,
  }) =>
      ContactData(
        id: id ?? this.id,
        name: name ?? this.name,
        countryCode: countryCode ?? this.countryCode,
        mobileNo: mobileNo ?? this.mobileNo,
        email: email ?? this.email,
        numberType: numberType ?? this.numberType,
        isSpam: isSpam ?? this.isSpam,
        isBlocked: isBlocked ?? this.isBlocked,
        markSpamByUser: markSpamByUser ?? this.markSpamByUser,
      );

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        numberType: json["number_type"],
        isSpam: json["is_spam"],
        isBlocked: json["is_blocked"],
        markSpamByUser: json["markspambyuser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "mobile_no": mobileNo,
        "email": email,
        "number_type": numberType,
        "is_spam": isSpam,
        "is_blocked": isBlocked,
        "markspambyuser": markSpamByUser,
      };
}
