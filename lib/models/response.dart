// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  final int? statusCode;
  final String? message;

  Response({
    this.statusCode,
    this.message,
  });

  Response copyWith({
    int? statusCode,
    String? message,
  }) =>
      Response(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
      };
}
