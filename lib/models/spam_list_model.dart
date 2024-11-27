// To parse this JSON data, do
//
//     final spamListResponse = spamListResponseFromJson(jsonString);

import 'dart:convert';

SpamListResponse spamListResponseFromJson(String str) => SpamListResponse.fromJson(json.decode(str));

String spamListResponseToJson(SpamListResponse data) => json.encode(data.toJson());

class SpamListResponse {
  final int? statusCode;
  final List<SpamData>? spamcontactslist;

  SpamListResponse({
    this.statusCode,
    this.spamcontactslist,
  });

  factory SpamListResponse.fromJson(Map<String, dynamic> json) => SpamListResponse(
    statusCode: json["status_code"],
    spamcontactslist: json["spamcontactslist"] == null ? [] : List<SpamData>.from(json["spamcontactslist"]!.map((x) => SpamData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "spamcontactslist": spamcontactslist == null ? [] : List<dynamic>.from(spamcontactslist!.map((x) => x.toJson())),
  };
}

class SpamData {
  final String? name;
  final String? id;
  final String? comments;
  final String? numberType;
  final String? spamNo;
  final String? categoryName;
  final String? categoryId;


  SpamData({
    this.name,
    this.id,
    this.comments,
    this.numberType,
    this.spamNo,
    this.categoryName,
    this.categoryId,
  });

  factory SpamData.fromJson(Map<String, dynamic> json) => SpamData(
    name: json["name"],
    id: json["id"],
    comments: json["comments"],
    numberType: json["number_type"],
    spamNo: json["spam_no"],
    categoryName: json["category_name"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "comments": comments,
    "number_type": numberType,
    "spam_no": spamNo,
    "category_name": categoryName,
    "category_id": categoryId,
  };
}
