// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) => CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) => json.encode(data.toJson());

class CategoryListResponse {
  final int? statusCode;
  final List<CategoryData>? categorylist;

  CategoryListResponse({
    this.statusCode,
    this.categorylist,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) => CategoryListResponse(
    statusCode: json["status_code"],
    categorylist: json["categorylist"] == null ? [] : List<CategoryData>.from(json["categorylist"]!.map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "categorylist": categorylist == null ? [] : List<dynamic>.from(categorylist!.map((x) => x.toJson())),
  };
}

class CategoryData {
  final String? cateId;
  final String? cateName;
  final String? cateIsactive;
  final DateTime? cateCreatedDate;
  final DateTime? cateModifiedDate;
  final String? cateSlug;
  final String? photo;

  CategoryData({
    this.cateId,
    this.cateName,
    this.cateIsactive,
    this.cateCreatedDate,
    this.cateModifiedDate,
    this.cateSlug,
    this.photo,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    cateId: json["cate_id"],
    cateName: json["cate_name"],
    cateIsactive: json["cate_isactive"],
    cateCreatedDate: json["cate_created_date"] == null ? null : DateTime.parse(json["cate_created_date"]),
    cateModifiedDate: json["cate_modified_date"] == null ? null : DateTime.parse(json["cate_modified_date"]),
    cateSlug: json["cate_slug"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "cate_id": cateId,
    "cate_name": cateName,
    "cate_isactive": cateIsactive,
    "cate_created_date": cateCreatedDate?.toIso8601String(),
    "cate_modified_date": cateModifiedDate?.toIso8601String(),
    "cate_slug": cateSlug,
    "photo": photo,
  };
}
