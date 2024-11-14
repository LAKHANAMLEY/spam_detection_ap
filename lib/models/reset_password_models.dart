/// To parse this JSON data, do
//
//     final resetResponse = resetResponseFromJson(jsonString);

import 'dart:convert';

ResetResponse resetResponseFromJson(String str) => ResetResponse.fromJson(json.decode(str));

String resetResponseToJson(ResetResponse data) => json.encode(data.toJson());

class ResetResponse {
  final int? statusCode;
  final String? message;

  ResetResponse({
    this.statusCode,
    this.message,
  });

  factory ResetResponse.fromJson(Map<String, dynamic> json) => ResetResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
