// To parse this JSON data, do
//
//     final changePasswordResponse = changePasswordResponseFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponse changePasswordResponseFromJson(String str) => ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) => json.encode(data.toJson());

class ChangePasswordResponse {
  final int? statusCode;
  final String? message;

  ChangePasswordResponse({
    this.statusCode,
    this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
