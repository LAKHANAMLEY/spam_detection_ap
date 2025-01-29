// To parse this JSON data, do
//
//     final forgotPasswordPhoneResponse = forgotPasswordPhoneResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordPhoneResponse forgotPasswordPhoneResponseFromJson(String str) =>
    ForgotPasswordPhoneResponse.fromJson(json.decode(str));

String forgotPasswordPhoneResponseToJson(ForgotPasswordPhoneResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordPhoneResponse {
  final int? statusCode;
  final String? message;
  final int? otp;

  ForgotPasswordPhoneResponse({
    this.statusCode,
    this.message,
    this.otp,
  });

  factory ForgotPasswordPhoneResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordPhoneResponse(
        statusCode: json["status_code"],
        message: json["message"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "otp": otp,
      };
}
