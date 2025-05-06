// To parse this JSON data, do
//
//     final smsListResponse = smsListResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

class SmsLog {
  final String? id;
  final String? address;
  final String? countryCode;
  final String? isSpam;
  final DateTime? date;
  final String? body;
  final int? unreadReceivedSms;
  final int? isMarkSpam;
  final String? name;
  final String? sendreceiveDatetime;
  final int? totalMarkSpamCountByUser;
  final List<SmsDetail>? smsDetails;
  final bool synced;

  SmsLog({
    this.id,
    this.address,
    this.countryCode,
    this.isSpam,
    this.date,
    this.body,
    this.unreadReceivedSms,
    this.isMarkSpam,
    this.name,
    this.sendreceiveDatetime,
    this.totalMarkSpamCountByUser,
    this.smsDetails,
    this.synced = false,
  });

  factory SmsLog.fromJson(Map<String, dynamic> json) => SmsLog(
      id: json["id"],
      address: json["address"],
      countryCode: json["country_code"],
      isSpam: json["is_spam"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      body: json["body"],
      unreadReceivedSms: json["unread_received_sms"],
      isMarkSpam: json["is_mark_spam"],
      name: json["name"],
      sendreceiveDatetime: json["sendreceive_datetime"],
      totalMarkSpamCountByUser: json["total_mark_spam_count_by_user"],
      smsDetails: json["sms_details"] == null
          ? []
          : List<SmsDetail>.from(
              json["sms_details"]!.map((x) => SmsDetail.fromJson(x))),
      synced: json["synced"] == 1);

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "country_code": countryCode,
        "is_spam": isSpam,
        "date": date?.toIso8601String(),
        "body": body,
        "unread_received_sms": unreadReceivedSms,
        "is_mark_spam": isMarkSpam,
        "name": name,
        "sendreceive_datetime": sendreceiveDatetime,
        "total_mark_spam_count_by_user": totalMarkSpamCountByUser,
        "sms_details": smsDetails == null
            ? []
            : List<dynamic>.from(smsDetails!.map((x) => x.toJson())),
        "synced": synced ? 1 : 0,
      };

  // SQLite integration
  // factory SmsLog.fromMap(Map<String, dynamic> map) => SmsLog(
  //       id: map['id'],
  //       address: map['address'],
  //       countryCode: map['country_code'],
  //       isSpam: map['is_spam'],
  //       date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
  //       body: map['body'],
  //       unreadReceivedSms: map['unread_received_sms'],
  //       isMarkSpam: map['is_mark_spam'],
  //       name: map['name'],
  //       sendreceiveDatetime: map['sendreceive_datetime'],
  //       totalMarkSpamCountByUser: map['total_mark_spam_count_by_user'],
  //       smsDetails: null, // handled separately
  //       synced: map["synced"] == 1,
  //     );

  Map<String, dynamic> toMap() => {
        'id': id,
        'address': address,
        'country_code': countryCode,
        'is_spam': isSpam,
        'date': date?.toIso8601String(),
        'body': body,
        'unread_received_sms': unreadReceivedSms,
        'is_mark_spam': isMarkSpam,
        'name': name,
        'sendreceive_datetime': sendreceiveDatetime,
        'total_mark_spam_count_by_user': totalMarkSpamCountByUser,
        'synced': synced ? 1 : 0
      };

  SmsLog copyWith({
    String? id,
    String? address,
    String? countryCode,
    String? isSpam,
    DateTime? date,
    String? body,
    int? unreadReceivedSms,
    int? isMarkSpam,
    String? name,
    String? sendreceiveDatetime,
    int? totalMarkSpamCountByUser,
    List<SmsDetail>? smsDetails,
    bool? synced,
  }) =>
      SmsLog(
        id: id ?? this.id,
        address: address ?? this.address,
        countryCode: countryCode ?? this.countryCode,
        isSpam: isSpam ?? this.isSpam,
        date: date ?? this.date,
        body: body ?? this.body,
        unreadReceivedSms: unreadReceivedSms ?? this.unreadReceivedSms,
        isMarkSpam: isMarkSpam ?? this.isMarkSpam,
        name: name ?? this.name,
        sendreceiveDatetime: sendreceiveDatetime ?? this.sendreceiveDatetime,
        totalMarkSpamCountByUser:
            totalMarkSpamCountByUser ?? this.totalMarkSpamCountByUser,
        smsDetails: smsDetails ?? this.smsDetails,
        synced: synced ?? this.synced,
      );

  static SmsLog fromSmsMessage(
          SmsMessage sms, ContactData? contact, SmsDetail? serverLog) =>
      SmsLog(
        id: sms.address?.separatePhoneAndPhoneCode().phone,
        body: sms.body,
        sendreceiveDatetime: sms.dateSent.toString(),
        address: sms.address?.separatePhoneAndPhoneCode().phone,
        countryCode: sms.address?.separatePhoneAndPhoneCode().phoneCode,
        name: contact?.name ?? serverLog?.name,
        date: sms.date,
        isMarkSpam: serverLog?.isMarkSpam ?? 0,
        isSpam: serverLog?.isSpam,
        unreadReceivedSms: serverLog?.unreadReceivedSms,
        synced: serverLog?.synced ?? false,
      );

  static SmsLog fromSmsLog(SmsLog? serverLog) => SmsLog(
        id: serverLog?.id,
        address: serverLog?.address,
        countryCode: serverLog?.countryCode,
        isSpam: serverLog?.isSpam,
        date: serverLog?.date,
        body: serverLog?.body,
        unreadReceivedSms: serverLog?.unreadReceivedSms,
        isMarkSpam: serverLog?.isMarkSpam,
        name: serverLog?.name,
        sendreceiveDatetime: serverLog?.sendreceiveDatetime,
        totalMarkSpamCountByUser: serverLog?.totalMarkSpamCountByUser,
        smsDetails: serverLog?.smsDetails,
        synced: serverLog?.synced ?? false,
      );
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
  final int? isMarkSpam;
  final String? spamMessage;
  final String? score;
  final String? isManually;
  final String? address;
  final String? countryCode;
  final DateTime? date;
  final String? name;
  final int? unreadReceivedSms;
  final bool synced;

  SmsDetail(
      {this.body,
      this.isRead,
      this.messageState,
      this.messageKind,
      this.queryKind,
      this.sendreceiveDatetime,
      this.threadId,
      this.id,
      this.deviceMessageId,
      this.isSpam,
      this.isMarkSpam,
      this.spamMessage,
      this.score,
      this.isManually,
      this.address,
      this.countryCode,
      this.date,
      this.name,
      this.unreadReceivedSms,
      this.synced = false});

  factory SmsDetail.fromJson(Map<String, dynamic> json) => SmsDetail(
      body: json["body"],
      isRead: json["is_read"],
      messageState: json["MessageState"],
      messageKind: json["MessageKind"],
      queryKind: json["QueryKind"],
      sendreceiveDatetime:
          json["send_receiveDatetime"]?.toString().isEmpty ?? true
              ? null
              : DateTime.tryParse(json["send_receiveDatetime"]),
      threadId: json["thread_id"],
      id: json["id"],
      deviceMessageId: json["_id"],
      isSpam: json["is_spam"],
      isMarkSpam: json["is_mark_spam"],
      spamMessage: json["spam_message"],
      score: json["score"],
      isManually: json["isManually"],
      address: json["address"],
      countryCode: json["countryCode"],
      date: json["date"]?.toString().isEmpty ?? true
          ? null
          : DateTime.tryParse(json["date"]),
      name: json["name"],
      unreadReceivedSms: json["unread_received_sms"],
      synced: json["synced"] == 1);

  Map<String, dynamic> toJson() => {
        "body": body,
        "is_read": isRead,
        "MessageState": messageState,
        "MessageKind": messageKind,
        "QueryKind": queryKind,
        "send_receiveDatetime": sendreceiveDatetime?.toIso8601String(),
        "thread_id": threadId,
        "id": id,
        "_id": deviceMessageId,
        "is_spam": isSpam,
        "is_mark_spam": isMarkSpam,
        "spam_message": spamMessage,
        "score": score,
        "isManually": isManually,
        "address": address,
        "countryCode": countryCode,
        "date": date?.toIso8601String(),
        "name": name,
        "unread_received_sms": unreadReceivedSms,
        "synced": synced ? 1 : 0
      };

  // Original fromSmsMessage method
  static SmsDetail fromSmsMessage(
          SmsMessage sms, SmsDetail? serverLog, ContactData? contact) =>
      SmsDetail(
        id: serverLog?.address ??
            sms.address?.separatePhoneAndPhoneCode().phone,
        deviceMessageId: sms.id?.toString(),
        address: serverLog?.address ??
            sms.address?.separatePhoneAndPhoneCode().phone,
        countryCode: serverLog?.countryCode ??
            sms.address?.separatePhoneAndPhoneCode().phoneCode,
        body: sms.body,
        date: sms.date,
        messageKind: sms.kind?.name,
        messageState: sms.state.name,
        name: contact?.name ?? serverLog?.name ?? sms.sender,
        threadId: sms.threadId?.toString(),
        sendreceiveDatetime: sms.dateSent,
        isSpam: serverLog?.isSpam,
        isMarkSpam: serverLog?.isMarkSpam,
        isRead: serverLog?.isRead,
        queryKind: serverLog?.queryKind,
        score: serverLog?.score,
        spamMessage: serverLog?.spamMessage,
        isManually: serverLog?.isManually,
        synced: serverLog?.synced ?? false,
      );

  // Corrected fromSmsLog method (from your original version)
  static SmsDetail? fromSmsLog(SmsLog? serverLog) {
    var detail = serverLog?.smsDetails?.firstOrNull;
    return SmsDetail(
        id: serverLog?.id,
        deviceMessageId: serverLog?.id,
        address: serverLog?.address,
        countryCode: serverLog?.countryCode,
        body: detail?.body,
        date: serverLog?.date,
        messageKind: detail?.messageKind,
        messageState: detail?.messageState,
        name: serverLog?.name,
        threadId: detail?.threadId,
        sendreceiveDatetime: detail?.date,
        isSpam: serverLog?.isSpam,
        isMarkSpam: serverLog?.isMarkSpam,
        isRead: detail?.isRead,
        queryKind: detail?.queryKind,
        score: detail?.score,
        spamMessage: detail?.spamMessage,
        isManually: detail?.isManually,
        synced: detail?.synced ?? false);
  }

  // copyWith method
  SmsDetail copyWith({
    String? body,
    String? isRead,
    String? messageState,
    String? messageKind,
    String? queryKind,
    DateTime? sendreceiveDatetime,
    String? threadId,
    String? id,
    String? deviceMessageId,
    String? isSpam,
    int? isMarkSpam,
    String? spamMessage,
    String? score,
    String? isManually,
    String? address,
    String? countryCode,
    DateTime? date,
    String? name,
    int? unreadReceivedSms,
    bool? synced,
  }) =>
      SmsDetail(
        body: body ?? this.body,
        isRead: isRead ?? this.isRead,
        messageState: messageState ?? this.messageState,
        messageKind: messageKind ?? this.messageKind,
        queryKind: queryKind ?? this.queryKind,
        sendreceiveDatetime: sendreceiveDatetime ?? this.sendreceiveDatetime,
        threadId: threadId ?? this.threadId,
        id: id ?? this.id,
        deviceMessageId: deviceMessageId ?? this.deviceMessageId,
        isSpam: isSpam ?? this.isSpam,
        isMarkSpam: isMarkSpam ?? this.isMarkSpam,
        spamMessage: spamMessage ?? this.spamMessage,
        score: score ?? this.score,
        isManually: isManually ?? this.isManually,
        address: address ?? this.address,
        countryCode: countryCode ?? this.countryCode,
        date: date ?? this.date,
        name: name ?? this.name,
        unreadReceivedSms: unreadReceivedSms ?? this.unreadReceivedSms,
        synced: synced ?? this.synced,
      );
}

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

// class SmsLog {
//   final String? id;
//   final String? address;
//   final String? countryCode;
//   final String? isSpam;
//   final DateTime? date;
//   final String? body;
//   final int? unreadReceivedSms;
//   final int? isMarkSpam;
//   final String? name;
//   final String? sendreceiveDatetime;
//   final int? totalMarkSpamCountByUser;
//   final List<SmsDetail>? smsDetails;

//   SmsLog({
//     this.id,
//     this.address,
//     this.countryCode,
//     this.isSpam,
//     this.date,
//     this.body,
//     this.unreadReceivedSms,
//     this.isMarkSpam,
//     this.name,
//     this.sendreceiveDatetime,
//     this.totalMarkSpamCountByUser,
//     this.smsDetails,
//   });

//   SmsLog copyWith({
//     String? id,
//     String? address,
//     String? countryCode,
//     String? isSpam,
//     DateTime? date,
//     String? body,
//     int? unreadReceivedSms,
//     int? isMarkSpam,
//     String? name,
//     String? sendreceiveDatetime,
//     int? totalMarkSpamCountByUser,
//     List<SmsDetail>? smsDetails,
//   }) =>
//       SmsLog(
//         id: id ?? this.id,
//         address: address ?? this.address,
//         countryCode: countryCode ?? this.countryCode,
//         isSpam: isSpam ?? this.isSpam,
//         date: date ?? this.date,
//         body: body ?? this.body,
//         unreadReceivedSms: unreadReceivedSms ?? this.unreadReceivedSms,
//         isMarkSpam: isMarkSpam ?? this.isMarkSpam,
//         name: name ?? this.name,
//         sendreceiveDatetime: sendreceiveDatetime ?? this.sendreceiveDatetime,
//         totalMarkSpamCountByUser:
//             totalMarkSpamCountByUser ?? this.totalMarkSpamCountByUser,
//         smsDetails: smsDetails ?? this.smsDetails,
//       );

//   factory SmsLog.fromJson(Map<String, dynamic> json) => SmsLog(
//         id: json["id"],
//         address: json["address"],
//         countryCode: json["country_code"],
//         isSpam: json["is_spam"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         body: json["body"],
//         unreadReceivedSms: json["unread_received_sms"],
//         isMarkSpam: json["is_mark_spam"],
//         name: json["name"],
//         sendreceiveDatetime: json["sendreceive_datetime"],
//         totalMarkSpamCountByUser: json["total_mark_spam_count_by_user"],
//         smsDetails: json["sms_details"] == null
//             ? []
//             : List<SmsDetail>.from(
//                 json["sms_details"]!.map((x) => SmsDetail.fromJson(x))),
//       );

//   static SmsLog fromSmsMessage(
//           SmsMessage sms, ContactData? contact, SmsDetail? serverLog) =>
//       SmsLog(
//         id: sms.address?.separatePhoneAndPhoneCode().phone,
//         address: sms.address?.separatePhoneAndPhoneCode().phone,
//         countryCode: sms.address?.separatePhoneAndPhoneCode().phoneCode,
//         name: contact?.name ?? serverLog?.name,
//         date: sms.date,
//         isMarkSpam: serverLog?.isMarkSpam ?? 0,
//         isSpam: serverLog?.isSpam,
//         unreadReceivedSms: serverLog?.unreadReceivedSms,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "address": address,
//         "country_code": countryCode,
//         "is_spam": isSpam,
//         "date": date?.toIso8601String(),
//         "body": body,
//         "unread_received_sms": unreadReceivedSms,
//         "is_mark_spam": isMarkSpam,
//         "name": name,
//         "sendreceive_datetime": sendreceiveDatetime,
//         "total_mark_spam_count_by_user": totalMarkSpamCountByUser,
//         "sms_details": smsDetails == null
//             ? []
//             : List<dynamic>.from(smsDetails!.map((x) => x.toJson())),
//       };
// }

// class SmsLog {
//   final String? id;
//   final String? address;
//   final String? countryCode;
//   final int? unreadReceivedSms;
//   final String? name;
//   final List<SmsDetail>? smsDetails;
//   final int? isMarkSpam;
//   final DateTime? date;

//   SmsLog({
//     this.id,
//     this.address,
//     this.countryCode,
//     this.unreadReceivedSms,
//     this.smsDetails,
//     this.name,
//     this.isMarkSpam,
//     this.date,
//   });

//   factory SmsLog.fromJson(Map<String, dynamic> json) => SmsLog(
//         id: json["id"],
//         address: json["address"],
//         name: json["name"],
//         countryCode: json["country_code"],
//         unreadReceivedSms: json["unread_received_sms"],
//         smsDetails: json["sms_details"] == null
//             ? []
//             : List<SmsDetail>.from(
//                 json["sms_details"]!.map((x) => SmsDetail.fromJson(x))),
//         isMarkSpam: json["is_mark_spam"],
//         date: DateTime.tryParse(json["date"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "address": address,
//         "country_code": countryCode,
//         "unread_received_sms": unreadReceivedSms,
//         "name": name,
//         "sms_details": smsDetails == null
//             ? []
//             : List<dynamic>.from(smsDetails!.map((x) => x.toJson())),
//         "is_mark_spam": isMarkSpam,
//         "date": date,
//       };

//   SmsLog copyWith({
//     String? id,
//     String? address,
//     String? countryCode,
//     int? unreadReceivedSms,
//     String? name,
//     List<SmsDetail>? smsDetails,
//     int? isMarkSpam,
//     DateTime? date,
//   }) {
//     return SmsLog(
//       id: id ?? this.id,
//       address: address ?? this.address,
//       countryCode: countryCode ?? this.countryCode,
//       unreadReceivedSms: unreadReceivedSms ?? this.unreadReceivedSms,
//       name: name ?? this.name,
//       smsDetails: smsDetails ?? this.smsDetails,
//       isMarkSpam: isMarkSpam ?? this.isMarkSpam,
//       date: date ?? this.date,
//     );
//   }

//   static SmsLog fromSmsMessage(
//           SmsMessage sms, ContactData? contact, SmsDetail? serverLog) =>
//       SmsLog(
//         id: sms.address,
//         address: sms.address,
//         countryCode: sms.address?.separatePhoneAndPhoneCode().phoneCode,
//         name: contact?.name ?? serverLog?.name,
//         date: sms.date,
//         isMarkSpam: serverLog?.isMarkSpam ?? 0,
//         unreadReceivedSms: serverLog?.unreadReceivedSms,
//       );
// }

// class SmsDetail {
//   final String? body;
//   final String? isRead;
//   final String? messageState;
//   final String? messageKind;
//   final String? queryKind;
//   final DateTime? sendreceiveDatetime;
//   final String? threadId;
//   final String? id;
//   final String? deviceMessageId;
//   final String? isSpam;
//   final int? isMarkSpam;
//   final String? spamMessage;
//   final String? score;
//   final String? isManually;
//   final String? address;
//   final String? countryCode;
//   final DateTime? date;
//   final String? name;
//   final int? unreadReceivedSms;

//   SmsDetail({
//     this.body,
//     this.isRead,
//     this.messageState,
//     this.messageKind,
//     this.queryKind,
//     this.sendreceiveDatetime,
//     this.threadId,
//     this.id,
//     this.deviceMessageId,
//     this.isSpam,
//     this.isMarkSpam,
//     this.spamMessage,
//     this.score,
//     this.isManually,
//     this.address,
//     this.countryCode,
//     this.date,
//     this.name,
//     this.unreadReceivedSms,
//   });

//   factory SmsDetail.fromJson(Map<String, dynamic> json) => SmsDetail(
//       body: json["body"],
//       isRead: json["is_read"],
//       messageState: json["MessageState"],
//       messageKind: json["MessageKind"],
//       queryKind: json["QueryKind"],
//       sendreceiveDatetime:
//           (json["send_receiveDatetime"]?.toString().isEmpty ?? true)
//               ? null
//               : DateTime.tryParse(json["send_receiveDatetime"]),
//       threadId: json["thread_id"],
//       id: json["id"],
//       deviceMessageId: json["_id"],
//       isSpam: json["is_spam"],
//       isMarkSpam: json["is_mark_spam"],
//       spamMessage: json["spam_message"],
//       score: json["score"],
//       // date: json["date"],
//       date: (json["date"]?.toString().isEmpty ?? true)
//           ? null
//           : DateTime.tryParse(json["date"]),
//       name: json["name"],
//       countryCode: json["countryCode"],
//       address: json["address"],
//       unreadReceivedSms: json["unread_received_sms"]);

//   Map<String, dynamic> toJson() => {
//         "body": body,
//         "is_read": isRead,
//         "MessageState": messageState,
//         "MessageKind": messageKind,
//         "QueryKind": queryKind,
//         "sendreceive_datetime": sendreceiveDatetime?.toIso8601String(),
//         "thread_id": threadId,
//         "id": id,
//         "_id": deviceMessageId,
//         "is_spam": isSpam,
//         "is_mark_spam": isMarkSpam,
//         "spam_message": spamMessage,
//         "score": score,
//         "name": name,
//         "countryCode": countryCode,
//         "address": address,
//         "date": date,
//         "unread_received_sms": unreadReceivedSms,
//       };

//   static SmsDetail fromSmsMessage(
//           SmsMessage sms, SmsDetail? serverLog, ContactData? contact) =>
//       SmsDetail(
//         id: serverLog?.address ??
//             sms.address?.separatePhoneAndPhoneCode().phone,
//         deviceMessageId: sms.id?.toString(),
//         address: serverLog?.address ??
//             sms.address?.separatePhoneAndPhoneCode().phone,
//         countryCode: serverLog?.countryCode ??
//             sms.address?.separatePhoneAndPhoneCode().phoneCode,
//         body: sms.body,
//         date: sms.date,
//         messageKind: sms.kind?.name,
//         messageState: sms.state.name,
//         name: contact?.name ?? serverLog?.name ?? sms.sender,
//         threadId: sms.threadId?.toString(),
//         sendreceiveDatetime: sms.dateSent,
//         isSpam: serverLog?.isSpam,
//         isMarkSpam: serverLog?.isMarkSpam,
//         isRead: serverLog?.isRead,
//         queryKind: serverLog?.queryKind,
//         score: serverLog?.score,
//         spamMessage: serverLog?.spamMessage,
//         isManually: serverLog?.isManually,
//       );

//   static SmsDetail? fromSmsLog(SmsLog? serverLog) {
//     var detail = serverLog?.smsDetails?.firstOrNull;
//     return SmsDetail(
//       id: serverLog?.id,
//       deviceMessageId: serverLog?.id,
//       address: serverLog?.address,
//       countryCode: serverLog?.countryCode,
//       body: detail?.body,
//       date: serverLog?.date,
//       messageKind: detail?.messageKind,
//       messageState: detail?.messageState,
//       name: serverLog?.name,
//       threadId: detail?.threadId,
//       sendreceiveDatetime: detail?.date,
//       isSpam: serverLog?.isSpam,
//       isMarkSpam: serverLog?.isMarkSpam,
//       isRead: detail?.isRead,
//       queryKind: detail?.queryKind,
//       score: detail?.score,
//       spamMessage: detail?.spamMessage,
//       isManually: detail?.isManually,
//     );
//   }
// }
