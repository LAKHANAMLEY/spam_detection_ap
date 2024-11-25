// To parse this JSON data, do
//
//     final planListResponse = planListResponseFromJson(jsonString);

import 'dart:convert';

PlanListResponse planListResponseFromJson(String str) => PlanListResponse.fromJson(json.decode(str));

String planListResponseToJson(PlanListResponse data) => json.encode(data.toJson());

class PlanListResponse {
  final int? statusCode;
  final List<Planslist>? planslist;

  PlanListResponse({
    this.statusCode,
    this.planslist,
  });

  factory PlanListResponse.fromJson(Map<String, dynamic> json) => PlanListResponse(
    statusCode: json["status_code"],
    planslist: json["planslist"] == null ? [] : List<Planslist>.from(json["planslist"]!.map((x) => Planslist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "planslist": planslist == null ? [] : List<dynamic>.from(planslist!.map((x) => x.toJson())),
  };
}

class Planslist {
  final String? title;
  final String? code;
  final String? description;
  final String? spamCheck;
  final String? support;
  final String? badge;
  final String? adsFree;
  final String? analytics;
  final String? familySharing;
  final String? whoViewedMyProfile;
  final String? whoSearchedForMe;
  final String? callRecording;
  final String? price;
  final String? isPopular;
  final String? plansType;
  final String? isAddon;
  final String? threeMonthPrice;
  final String? sixMonthPrice;
  final String? yearlyPrice;
  final String? emailProtection;

  Planslist({
    this.title,
    this.code,
    this.description,
    this.spamCheck,
    this.support,
    this.badge,
    this.adsFree,
    this.analytics,
    this.familySharing,
    this.whoViewedMyProfile,
    this.whoSearchedForMe,
    this.callRecording,
    this.price,
    this.isPopular,
    this.plansType,
    this.isAddon,
    this.threeMonthPrice,
    this.sixMonthPrice,
    this.yearlyPrice,
    this.emailProtection,
  });

  factory Planslist.fromJson(Map<String, dynamic> json) => Planslist(
    title: json["title"],
    code: json["code"],
    description: json["description"],
    spamCheck: json["spam_check"],
    support: json["support"],
    badge: json["badge"],
    adsFree: json["ads_free"],
    analytics: json["analytics"],
    familySharing: json["family_sharing"],
    whoViewedMyProfile: json["who_viewed_my_profile"],
    whoSearchedForMe: json["who_searched_for_me"],
    callRecording: json["call_recording"],
    price: json["price"],
    isPopular: json["is_popular"],
    plansType: json["plans_type"],
    isAddon: json["is_addon"],
    threeMonthPrice: json["three_month_price"],
    sixMonthPrice: json["six_month_price"],
    yearlyPrice: json["yearly_price"],
    emailProtection: json["email_protection"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "code": code,
    "description": description,
    "spam_check": spamCheck,
    "support": support,
    "badge": badge,
    "ads_free": adsFree,
    "analytics": analytics,
    "family_sharing": familySharing,
    "who_viewed_my_profile": whoViewedMyProfile,
    "who_searched_for_me": whoSearchedForMe,
    "call_recording": callRecording,
    "price": price,
    "is_popular": isPopular,
    "plans_type": plansType,
    "is_addon": isAddon,
    "three_month_price": threeMonthPrice,
    "six_month_price": sixMonthPrice,
    "yearly_price": yearlyPrice,
    "email_protection": emailProtection,
  };
}
