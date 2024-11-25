// To parse this JSON data, do
//
//     final changeSecurityPinResponse = changeSecurityPinResponseFromJson(jsonString);

import 'dart:convert';

ChangeSecurityPinResponse changeSecurityPinResponseFromJson(String str) => ChangeSecurityPinResponse.fromJson(json.decode(str));

String changeSecurityPinResponseToJson(ChangeSecurityPinResponse data) => json.encode(data.toJson());

class ChangeSecurityPinResponse {
  final int? statusCode;
  final String? message;

  ChangeSecurityPinResponse({
    this.statusCode,
    this.message,
  });

  factory ChangeSecurityPinResponse.fromJson(Map<String, dynamic> json) => ChangeSecurityPinResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
