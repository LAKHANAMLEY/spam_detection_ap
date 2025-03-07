// To parse this JSON data, do
//
//     final planListResponse = planListResponseFromJson(jsonString);

import 'dart:convert';

PlanListResponse planListResponseFromJson(String str) =>
    PlanListResponse.fromJson(json.decode(str));

String planListResponseToJson(PlanListResponse data) =>
    json.encode(data.toJson());

class PlanListResponse {
  final int? statusCode;
  final List<Planslist>? planslist;

  PlanListResponse({
    this.statusCode,
    this.planslist,
  });

  PlanListResponse copyWith({
    int? statusCode,
    List<Planslist>? planslist,
  }) =>
      PlanListResponse(
        statusCode: statusCode ?? this.statusCode,
        planslist: planslist ?? this.planslist,
      );

  factory PlanListResponse.fromJson(Map<String, dynamic> json) =>
      PlanListResponse(
        statusCode: json["status_code"],
        planslist: json["planslist"] == null
            ? []
            : List<Planslist>.from(
                json["planslist"]!.map((x) => Planslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "planslist": planslist == null
            ? []
            : List<dynamic>.from(planslist!.map((x) => x.toJson())),
      };
}

class Planslist {
  final String? id;
  final String? title;
  final String? code;
  final String? description;
  final String? price;
  final String? isPopular;
  final String? callProtection;
  final String? emailProtection;
  final String? smsProtection;
  final String? familySharing;
  final String? validity;
  final int? isActive;

  Planslist({
    this.id,
    this.title,
    this.code,
    this.description,
    this.price,
    this.isPopular,
    this.callProtection,
    this.emailProtection,
    this.smsProtection,
    this.familySharing,
    this.validity,
    this.isActive,
  });

  Planslist copyWith({
    String? id,
    String? title,
    String? code,
    String? description,
    String? price,
    String? isPopular,
    String? callProtection,
    String? emailProtection,
    String? smsProtection,
    String? familySharing,
    String? validity,
    int? isActive,
  }) =>
      Planslist(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        description: description ?? this.description,
        price: price ?? this.price,
        isPopular: isPopular ?? this.isPopular,
        callProtection: callProtection ?? this.callProtection,
        emailProtection: emailProtection ?? this.emailProtection,
        smsProtection: smsProtection ?? this.smsProtection,
        familySharing: familySharing ?? this.familySharing,
        validity: validity ?? this.validity,
        isActive: isActive ?? this.isActive,
      );

  factory Planslist.fromJson(Map<String, dynamic> json) => Planslist(
      id: json["id"],
      title: json["title"],
      code: json["code"],
      description: json["description"],
      price: json["price"],
      isPopular: json["is_popular"],
      callProtection: json["call_protection"],
      emailProtection: json["email_protection"],
      smsProtection: json["sms_protection"],
      familySharing: json["family_sharing"],
      validity: json["validity"],
      isActive: json["is_active"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "description": description,
        "price": price,
        "is_popular": isPopular,
        "call_protection": callProtection,
        "email_protection": emailProtection,
        "sms_protection": smsProtection,
        "family_sharing": familySharing,
        "validity": validity,
        "is_active": isActive,
      };
}
