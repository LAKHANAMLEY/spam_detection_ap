// To parse this JSON data, do
//
//     final countriesResponse = countriesResponseFromJson(jsonString);

import 'dart:convert';

CountriesResponse countriesResponseFromJson(String str) => CountriesResponse.fromJson(json.decode(str));

String countriesResponseToJson(CountriesResponse data) => json.encode(data.toJson());

class CountriesResponse {
  final int? statusCode;
  final List<Countrylist>? countrylist;

  CountriesResponse({
    this.statusCode,
    this.countrylist,
  });

  factory CountriesResponse.fromJson(Map<String, dynamic> json) => CountriesResponse(
    statusCode: json["status_code"],
    countrylist: json["countrylist"] == null ? [] : List<Countrylist>.from(json["countrylist"]!.map((x) => Countrylist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "countrylist": countrylist == null ? [] : List<dynamic>.from(countrylist!.map((x) => x.toJson())),
  };

  static fetchCountriesResponse() {}
}

class Countrylist {
  final String? id;
  final String? code;
  final String? nicename;
  final String? name;
  final String? iso;
  final String? numcode;
  final String? phonecode;

  Countrylist({
    this.id,
    this.code,
    this.nicename,
    this.name,
    this.iso,
    this.numcode,
    this.phonecode,
  });

  factory Countrylist.fromJson(Map<String, dynamic> json) => Countrylist(
    id: json["id"],
    code: json["code"],
    nicename: json["nicename"],
    name: json["name"],
    iso: json["iso"],
    numcode: json["numcode"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "nicename": nicename,
    "name": name,
    "iso": iso,
    "numcode": numcode,
    "phonecode": phonecode,
  };
}
