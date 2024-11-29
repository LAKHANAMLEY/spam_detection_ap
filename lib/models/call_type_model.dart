// To parse this JSON data, do
//
//     final callTypeResponse = callTypeResponseFromJson(jsonString);

import 'dart:convert';

CallTypeResponse callTypeResponseFromJson(String str) => CallTypeResponse.fromJson(json.decode(str));

String callTypeResponseToJson(CallTypeResponse data) => json.encode(data.toJson());

class CallTypeResponse {
  final int? statusCode;
  final List<Calltype>? calltype;

  CallTypeResponse({
    this.statusCode,
    this.calltype,
  });

  factory CallTypeResponse.fromJson(Map<String, dynamic> json) => CallTypeResponse(
    statusCode: json["status_code"],
    calltype: json["calltype"] == null ? [] : List<Calltype>.from(json["calltype"]!.map((x) => Calltype.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "calltype": calltype == null ? [] : List<dynamic>.from(calltype!.map((x) => x.toJson())),
  };
}

class Calltype {
  final String? id;
  final String? name;

  Calltype({
    this.id,
    this.name,
  });

  factory Calltype.fromJson(Map<String, dynamic> json) => Calltype(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
