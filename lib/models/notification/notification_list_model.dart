// To parse this JSON data, do
//
//     final notificationListResponse = notificationListResponseFromJson(jsonString);

import 'dart:convert';

NotificationListResponse notificationListResponseFromJson(String str) =>
    NotificationListResponse.fromJson(json.decode(str));

String notificationListResponseToJson(NotificationListResponse data) =>
    json.encode(data.toJson());

class NotificationListResponse {
  final int? statusCode;
  final int? totalUnreadNotifications;
  final String? message;
  final List<NotificationData>? notificationsList;

  NotificationListResponse({
    this.statusCode,
    this.totalUnreadNotifications,
    this.message,
    this.notificationsList,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      NotificationListResponse(
        statusCode: json["status_code"],
        totalUnreadNotifications: json["total_unread_notifications"],
        message: json["message"],
        notificationsList: json["notifications_list"] == null
            ? []
            : List<NotificationData>.from(json["notifications_list"]!
                .map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "total_unread_notifications": totalUnreadNotifications,
        "message": message,
        "notifications_list": notificationsList == null
            ? []
            : List<dynamic>.from(notificationsList!.map((x) => x.toJson())),
      };
}

class NotificationData {
  final String? id;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final String? senderId;
  final String? receiverId;
  final String? type;
  final String? message;
  final String? isRead;
  final String? otherId;
  final String? otherValue;
  final String? sentTime;
  final String? senderName;
  final String? photo;

  NotificationData({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.senderId,
    this.receiverId,
    this.type,
    this.message,
    this.isRead,
    this.otherId,
    this.otherValue,
    this.sentTime,
    this.senderName,
    this.photo,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        type: json["type"],
        message: json["message"],
        isRead: json["is_read"],
        otherId: json["other_id"],
        otherValue: json["other_value"],
        sentTime: json["sent_time"],
        senderName: json["sender_name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_date": createdDate?.toIso8601String(),
        "updated_date": updatedDate?.toIso8601String(),
        "sender_id": senderId,
        "receiver_id": receiverId,
        "type": type,
        "message": message,
        "is_read": isRead,
        "other_id": otherId,
        "other_value": otherValue,
        "sent_time": sentTime,
        "sender_name": senderName,
        "photo": photo,
      };
}
