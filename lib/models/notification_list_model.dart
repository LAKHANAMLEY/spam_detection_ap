// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  final int? statusCode;
  final int? totalUnreadNotifications;
  final List<dynamic>? notificationsList;
  final String? message;

  NotificationResponse(
      {this.statusCode,
      this.totalUnreadNotifications,
      this.notificationsList,
      this.message});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        statusCode: json["status_code"],
        totalUnreadNotifications: json["total_unread_notifications"],
        message: json["message"],
        notificationsList: json["notifications_list"] == null
            ? []
            : List<dynamic>.from(json["notifications_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "total_unread_notifications": totalUnreadNotifications,
        "message": message,
        "notifications_list": notificationsList == null
            ? []
            : List<dynamic>.from(notificationsList!.map((x) => x)),
      };
}
