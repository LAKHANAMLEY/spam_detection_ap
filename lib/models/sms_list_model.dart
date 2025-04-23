// To parse this JSON data, do
//
//     final smsListResponse = smsListResponseFromJson(jsonString);

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
  final String? id;
  final String? address;
  final String? countryCode;
  final int? unreadReceivedSms;
  final String? name;
  final List<SmsDetail>? smsDetails;
  final int? isMarkSpam;
  final DateTime? date;

  SmsLog({
    this.id,
    this.address,
    this.countryCode,
    this.unreadReceivedSms,
    this.smsDetails,
    this.name,
    this.isMarkSpam,
    this.date,
  });

  factory SmsLog.fromJson(Map<String, dynamic> json) => SmsLog(
        id: json["id"],
        address: json["address"],
        name: json["name"],
        countryCode: json["country_code"],
        unreadReceivedSms: json["unread_received_sms"],
        smsDetails: json["sms_details"] == null
            ? []
            : List<SmsDetail>.from(
                json["sms_details"]!.map((x) => SmsDetail.fromJson(x))),
        isMarkSpam: json["is_mark_spam"],
        date: DateTime.tryParse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "country_code": countryCode,
        "unread_received_sms": unreadReceivedSms,
        "name": name,
        "sms_details": smsDetails == null
            ? []
            : List<dynamic>.from(smsDetails!.map((x) => x.toJson())),
        "is_mark_spam": isMarkSpam,
        "date": date,
      };

  SmsLog copyWith({
    String? id,
    String? address,
    String? countryCode,
    int? unreadReceivedSms,
    String? name,
    List<SmsDetail>? smsDetails,
    int? isMarkSpam,
    DateTime? date,
  }) {
    return SmsLog(
      id: id ?? this.id,
      address: address ?? this.address,
      countryCode: countryCode ?? this.countryCode,
      unreadReceivedSms: unreadReceivedSms ?? this.unreadReceivedSms,
      name: name ?? this.name,
      smsDetails: smsDetails ?? this.smsDetails,
      isMarkSpam: isMarkSpam ?? this.isMarkSpam,
      date: date ?? this.date,
    );
  }
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
  final String? deviceMessageId;
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
    this.deviceMessageId,
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
        id: json["id"],
        deviceMessageId: json["_id"],
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
        "id": id,
        "_id": deviceMessageId,
        "is_spam": isSpam,
        "spam_message": spamMessage,
        "score": score,
        "name": name,
        "countryCode": countryCode,
        "address": address,
        "date": date,
      };
}
