// To parse this JSON data, do
//
//     final numberTypeResponse = numberTypeResponseFromJson(jsonString);

import 'dart:convert';

NumberTypeResponse numberTypeResponseFromJson(String str) => NumberTypeResponse.fromJson(json.decode(str));

String numberTypeResponseToJson(NumberTypeResponse data) => json.encode(data.toJson());

class NumberTypeResponse {
  final int? statusCode;
  final List<Numbertypelist>? numbertypelist;

  NumberTypeResponse({
    this.statusCode,
    this.numbertypelist,
  });

  factory NumberTypeResponse.fromJson(Map<String, dynamic> json) => NumberTypeResponse(
    statusCode: json["status_code"],
    numbertypelist: json["numbertypelist"] == null ? [] : List<Numbertypelist>.from(json["numbertypelist"]!.map((x) => Numbertypelist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "numbertypelist": numbertypelist == null ? [] : List<dynamic>.from(numbertypelist!.map((x) => x.toJson())),
  };
}

class Numbertypelist {
  final String? name;
  final String? id;

  Numbertypelist({
    this.name,
    this.id,
  });

  factory Numbertypelist.fromJson(Map<String, dynamic> json) => Numbertypelist(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
