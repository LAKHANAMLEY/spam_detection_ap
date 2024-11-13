// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  final int? statusCode;
  final int? totalUnreadNotifications;
  final List<dynamic>? notificationsList;

  NotificationResponse({
    this.statusCode,
    this.totalUnreadNotifications,
    this.notificationsList,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    statusCode: json["status_code"],
    totalUnreadNotifications: json["total_unread_notifications"],
    notificationsList: json["notifications_list"] == null ? [] : List<dynamic>.from(json["notifications_list"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "total_unread_notifications": totalUnreadNotifications,
    "notifications_list": notificationsList == null ? [] : List<dynamic>.from(notificationsList!.map((x) => x)),
  };
}
