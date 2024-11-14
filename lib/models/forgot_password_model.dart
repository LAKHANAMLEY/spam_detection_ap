/// To parse this JSON data, do
library;
//
//     final forgotResponse = forgotResponseFromJson(jsonString);

import 'dart:convert';

ForgotResponse forgotResponseFromJson(String str) =>
    ForgotResponse.fromJson(json.decode(str));

String forgotResponseToJson(ForgotResponse data) => json.encode(data.toJson());

class ForgotResponse {
  final int? statusCode;
  final String? message;

  ForgotResponse({
    this.statusCode,
    this.message,
  });

  factory ForgotResponse.fromJson(Map<String, dynamic> json) => ForgotResponse(
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
      };
}
