// To parse this JSON data, do
//
//     final callDurationResponse = callDurationResponseFromJson(jsonString);

import 'dart:convert';

CallDurationResponse callDurationResponseFromJson(String str) => CallDurationResponse.fromJson(json.decode(str));

String callDurationResponseToJson(CallDurationResponse data) => json.encode(data.toJson());

class CallDurationResponse {
  final int? statusCode;
  final List<CallDurationUnit>? callDurationUnit;

  CallDurationResponse({
    this.statusCode,
    this.callDurationUnit,
  });

  factory CallDurationResponse.fromJson(Map<String, dynamic> json) => CallDurationResponse(
    statusCode: json["status_code"],
    callDurationUnit: json["call_duration_unit"] == null ? [] : List<CallDurationUnit>.from(json["call_duration_unit"]!.map((x) => CallDurationUnit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "call_duration_unit": callDurationUnit == null ? [] : List<dynamic>.from(callDurationUnit!.map((x) => x.toJson())),
  };
}

class CallDurationUnit {
  final String? id;
  final String? name;
  final String? slug;

  CallDurationUnit({
    this.id,
    this.name,
    this.slug,
  });

  factory CallDurationUnit.fromJson(Map<String, dynamic> json) => CallDurationUnit(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
