// To parse this JSON data, do
//
//     final notificationTypeResponse = notificationTypeResponseFromJson(jsonString);

import 'dart:convert';

NotificationTypeResponse notificationTypeResponseFromJson(String str) =>
    NotificationTypeResponse.fromJson(json.decode(str));
NotificationTypeResponse notificationTypeResponseFromJson(String str) =>
    NotificationTypeResponse.fromJson(json.decode(str));

String notificationTypeResponseToJson(NotificationTypeResponse data) =>
    json.encode(data.toJson());
String notificationTypeResponseToJson(NotificationTypeResponse data) =>
    json.encode(data.toJson());

class NotificationTypeResponse {
  final int? statusCode;
  final List<NotificationTypeData>? notificationType;

  NotificationTypeResponse({
    this.statusCode,
    this.notificationType,
    this.message,
  });

  factory NotificationTypeResponse.fromJson(Map<String, dynamic> json) =>
      NotificationTypeResponse(
        statusCode: json["status_code"],
        notificationType: json["notification_type"] == null
            ? []
            : List<NotificationType>.from(json["notification_type"]!
                .map((x) => NotificationType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "notification_type": notificationType == null
            ? []
            : List<dynamic>.from(notificationType!.map((x) => x.toJson())),
      };
        "status_code": statusCode,
        "notification_type": notificationType == null
            ? []
            : List<dynamic>.from(notificationType!.map((x) => x.toJson())),
      };
}

class NotificationTypeData {
  final String? id;
  final String? name;
  final String? code;
  final int? isPushReceive;
  final int? isNotificationReceive;
  final DateTime? callTime;

  NotificationTypeData({
    this.id,
    this.name,
    this.code,
    this.isPushReceive,
    this.isNotificationReceive,
    this.callTime,
  });

  factory NotificationType.fromJson(Map<String, dynamic> json) =>
      NotificationType(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        isPushReceive: json["is_push_receive"],
        isNotificationReceive: json["is_notification_receive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "is_push_receive": isPushReceive,
        "is_notification_receive": isNotificationReceive,
      };
        "id": id,
        "name": name,
        "code": code,
        "is_push_receive": isPushReceive,
        "is_notification_receive": isNotificationReceive,
      };
}
