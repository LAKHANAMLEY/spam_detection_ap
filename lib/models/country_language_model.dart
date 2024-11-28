// To parse this JSON data, do
//
//     final countryLanguageResponse = countryLanguageResponseFromJson(jsonString);

import 'dart:convert';

CountryLanguageResponse countryLanguageResponseFromJson(String str) => CountryLanguageResponse.fromJson(json.decode(str));

String countryLanguageResponseToJson(CountryLanguageResponse data) => json.encode(data.toJson());

class CountryLanguageResponse {
  final int? statusCode;
  final List<LanguageData>? languagelist;

  CountryLanguageResponse({
    this.statusCode,
    this.languagelist,
  });

  factory CountryLanguageResponse.fromJson(Map<String, dynamic> json) => CountryLanguageResponse(
    statusCode: json["status_code"],
    languagelist: json["languagelist"] == null ? [] : List<LanguageData>.from(json["languagelist"]!.map((x) => LanguageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "languagelist": languagelist == null ? [] : List<dynamic>.from(languagelist!.map((x) => x.toJson())),
  };
}

class LanguageData {
  final String? name;
  final String? id;

  LanguageData({
    this.name,
    this.id,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
