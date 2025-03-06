// To parse this JSON data, do
//
//     final smsListResponse = smsListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:spam_delection_app/globals/index.dart';

SmsListResponse smsListResponseFromJson(String str) =>
    SmsListResponse.fromJson(json.decode(str));

String smsListResponseToJson(SmsListResponse data) =>
    json.encode(data.toJson());

class SmsListResponse {
  final int? statusCode;
  final List<SmsLog>? smsLog;
  final String? message;

  SmsListResponse({
    this.statusCode,
    this.smsLog,
    this.message,
  });

  factory SmsListResponse.fromJson(Map<String, dynamic> json) =>
      SmsListResponse(
          statusCode: json["status_code"],
          smsLog: json["sms_log"] == null
              ? []
              : List<SmsLog>.from(
                  json["sms_log"]!.map((x) => SmsLog.fromJson(x))),
          message: json["message"]);

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "sms_log": smsLog == null
            ? []
            : List<dynamic>.from(smsLog!.map((x) => x.toJson())),
        "message": message
      };
}

class SmsLog {
  final String? address;
  final String? countryCode;
  final int? unreadReceivedSms;
  final String? name;
  final List<SmsDetail>? smsDetails;
  final int? isMarkSpam;

  SmsLog({
    this.address,
    this.countryCode,
    this.unreadReceivedSms,
    this.smsDetails,
    this.name,
    this.isMarkSpam,
  });

  factory SmsLog.fromJson(Map<String, dynamic> json) => SmsLog(
      address: json["address"],
      name: json["name"],
      countryCode: json["country_code"],
      unreadReceivedSms: json["unread_received_sms"],
      smsDetails: json["sms_details"] == null
          ? []
          : List<SmsDetail>.from(
              json["sms_details"]!.map((x) => SmsDetail.fromJson(x))),
      isMarkSpam: json["is_mark_spam"]);

  Map<String, dynamic> toJson() => {
        "address": address,
        "country_code": countryCode,
        "unread_received_sms": unreadReceivedSms,
        "name": name,
        "sms_details": smsDetails == null
            ? []
            : List<dynamic>.from(smsDetails!.map((x) => x.toJson())),
        "is_mark_spam": isMarkSpam,
      };
}

class SmsDetail {
  final String? body;
  final String? isRead;
  final String? messageState;
  final String? messageKind;
  final String? queryKind;
  final DateTime? sendreceiveDatetime;
  final String? threadId;
  final String? id;
  final String? isSpam;
  final String? spamMessage;
  final String? score;
  final String? isManually;
  final String? address;
  final String? countryCode;
  final DateTime? date;
  final String? name;

  SmsDetail({
    this.body,
    this.isRead,
    this.messageState,
    this.messageKind,
    this.queryKind,
    this.sendreceiveDatetime,
    this.threadId,
    this.id,
    this.isSpam,
    this.spamMessage,
    this.score,
    this.isManually,
    this.address,
    this.countryCode,
    this.date,
    this.name,
  });

  factory SmsDetail.fromJson(Map<String, dynamic> json) => SmsDetail(
        body: json["body"],
        isRead: json["is_read"],
        messageState: json["MessageState"],
        messageKind: json["MessageKind"],
        queryKind: json["QueryKind"],
        sendreceiveDatetime:
            (json["send_receiveDatetime"]?.toString().isEmpty ?? true)
                ? null
                : DateTime.tryParse(json["send_receiveDatetime"]),
        threadId: json["thread_id"],
        id: json["_id"],
        isSpam: json["is_spam"],
        spamMessage: json["spam_message"],
        score: json["score"],
        // date: json["date"],
        date: (json["date"]?.toString().isEmpty ?? true)
            ? null
            : DateTime.tryParse(json["date"]),
        name: json["name"],
        countryCode: json["countryCode"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "is_read": isRead,
        "MessageState": messageState,
        "MessageKind": messageKind,
        "QueryKind": queryKind,
        "sendreceive_datetime": sendreceiveDatetime?.toIso8601String(),
        "thread_id": threadId,
        "_id": id,
        "is_spam": isSpam,
        "spam_message": spamMessage,
        "score": score,
        "name": name,
        "countryCode": countryCode,
        "address": address,
        "date": date,
      };
}
