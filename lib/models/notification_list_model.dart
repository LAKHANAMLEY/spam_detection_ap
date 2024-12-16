// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationListResponse notificationResponseFromJson(String str) =>
    NotificationListResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationListResponse data) =>
    json.encode(data.toJson());

class NotificationListResponse {
  final int? statusCode;
  final int? totalUnreadNotifications;
  final List<dynamic>? notificationsList;
  final String? message;

  NotificationListResponse({
    this.statusCode,
    this.totalUnreadNotifications,
    this.notificationsList,
    this.message,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      NotificationListResponse(
        statusCode: json["status_code"],
        totalUnreadNotifications: json["total_unread_notifications"],
        notificationsList: json["notifications_list"] == null
            ? []
            : List<dynamic>.from(json["notifications_list"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "total_unread_notifications": totalUnreadNotifications,
        "notifications_list": notificationsList == null
            ? []
            : List<dynamic>.from(notificationsList!.map((x) => x)),
        "message": message,
      };
}
