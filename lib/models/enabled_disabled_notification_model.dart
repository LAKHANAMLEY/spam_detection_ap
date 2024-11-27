// To parse this JSON data, do
//
//     final enabledNotificationResponse = enabledNotificationResponseFromJson(jsonString);

import 'dart:convert';

EnabledNotificationResponse enabledNotificationResponseFromJson(String str) => EnabledNotificationResponse.fromJson(json.decode(str));

String enabledNotificationResponseToJson(EnabledNotificationResponse data) => json.encode(data.toJson());

class EnabledNotificationResponse {
  final int? statusCode;
  final String? message;

  EnabledNotificationResponse({
    this.statusCode,
    this.message,
  });

  factory EnabledNotificationResponse.fromJson(Map<String, dynamic> json) => EnabledNotificationResponse(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
