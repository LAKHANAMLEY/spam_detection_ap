// To parse this JSON data, do
//
//     final smsSpamListResponse = smsSpamListResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final smsSpamListResponse = smsSpamListResponseFromJson(jsonString);

import 'dart:convert';

SmsSpamListResponse smsSpamListResponseFromJson(String str) =>
    SmsSpamListResponse.fromJson(json.decode(str));

String smsSpamListResponseToJson(SmsSpamListResponse data) =>
    json.encode(data.toJson());

class SmsSpamListResponse {
  final int? statusCode;
  final List<SmsSpamList>? smsSpamList;

  SmsSpamListResponse({
    this.statusCode,
    this.smsSpamList,
  });

  factory SmsSpamListResponse.fromJson(Map<String, dynamic> json) =>
      SmsSpamListResponse(
        statusCode: json["status_code"],
        smsSpamList: json["sms_spam_list"] == null
            ? []
            : List<SmsSpamList>.from(
                json["sms_spam_list"]!.map((x) => SmsSpamList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "sms_spam_list": smsSpamList == null
            ? []
            : List<dynamic>.from(smsSpamList!.map((x) => x.toJson())),
      };
}

class SmsSpamList {
  final String? address;
  final DateTime? markDate;
  final String? comments;
  final String? category;
  final String? numberType;
  final String? categoryName;
  final String? name;
  final String? countryCode;

  SmsSpamList({
    this.address,
    this.markDate,
    this.comments,
    this.category,
    this.numberType,
    this.categoryName,
    this.name,
    this.countryCode,
  });

  factory SmsSpamList.fromJson(Map<String, dynamic> json) => SmsSpamList(
        address: json["address"],
        markDate: json["mark_date"] == null
            ? null
            : DateTime.parse(json["mark_date"]),
        comments: json["comments"],
        category: json["category"],
        numberType: json["number_type"],
        categoryName: json["category_name"],
        name: json["name"],
        //countryCode: json["country_code"]
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "mark_date": markDate?.toIso8601String(),
        "comments": comments,
        "category": category,
        "number_type": numberType,
        "category_name": categoryName,
        "name": name,
      };
}
