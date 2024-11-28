// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  final int? statusCode;
  final String? message;
  final dynamic data;

  Response({
    this.statusCode,
    this.message,
    this.data,
  });

  Response copyWith({
    int? statusCode,
    String? message,
    dynamic data,
  }) =>
      Response(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data,
      };
}
