// To parse this JSON data, do
//
//     final markSpamResponse = markSpamResponseFromJson(jsonString);

import 'dart:convert';

MarkSpamResponse markSpamResponseFromJson(String str) => MarkSpamResponse.fromJson(json.decode(str));

String markSpamResponseToJson(MarkSpamResponse data) => json.encode(data.toJson());

class MarkSpamResponse {
  final int? statusCode;
  final String? message;

  MarkSpamResponse({
    this.statusCode,
    this.message,
  });

  factory MarkSpamResponse.fromJson(Map<String, dynamic> json) => MarkSpamResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
