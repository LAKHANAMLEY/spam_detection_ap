// To parse this JSON data, do
//
//     final smsLogDetailsResponse = smsLogDetailsResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

SmsLogDetailsResponse smsLogDetailsResponseFromJson(String str) =>
    SmsLogDetailsResponse.fromJson(json.decode(str));

String smsLogDetailsResponseToJson(SmsLogDetailsResponse data) =>
    json.encode(data.toJson());

class SmsLogDetailsResponse {
  final int? statusCode;
  final List<SmsDetail>? smsLogDetails;

  SmsLogDetailsResponse({
    this.statusCode,
    this.smsLogDetails,
  });

  SmsLogDetailsResponse copyWith({
    int? statusCode,
    List<SmsDetail>? smsLogDetails,
  }) =>
      SmsLogDetailsResponse(
        statusCode: statusCode ?? this.statusCode,
        smsLogDetails: smsLogDetails ?? this.smsLogDetails,
      );

  factory SmsLogDetailsResponse.fromJson(Map<String, dynamic> json) =>
      SmsLogDetailsResponse(
        statusCode: json["status_code"],
        smsLogDetails: json["sms_log_details"] == null
            ? []
            : List<SmsDetail>.from(
                json["sms_log_details"]!.map((x) => SmsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "sms_log_details": smsLogDetails == null
            ? []
            : List<dynamic>.from(smsLogDetails!.map((x) => x.toJson())),
      };
}

// class SmsLogDetail {
//   final String? smsLogDetailId;
//   final String? address;
//   final String? body;
//   final String? isRead;
//   final MessageState? messageState;
//   final Kind? messageKind;
//   final Kind? queryKind;
//   final DateTime? date;
//   final String? threadId;
//   final String? id;
//   final String? isSpam;
//   final SpamMessage? spamMessage;
//   final String? score;
//   final SendreceiveDatetime? sendreceiveDatetime;

//   SmsLogDetail({
//     this.smsLogDetailId,
//     this.address,
//     this.body,
//     this.isRead,
//     this.messageState,
//     this.messageKind,
//     this.queryKind,
//     this.date,
//     this.threadId,
//     this.id,
//     this.isSpam,
//     this.spamMessage,
//     this.score,
//     this.sendreceiveDatetime,
//   });

//   SmsLogDetail copyWith({
//     String? smsLogDetailId,
//     String? address,
//     String? body,
//     String? isRead,
//     MessageState? messageState,
//     Kind? messageKind,
//     Kind? queryKind,
//     DateTime? date,
//     String? threadId,
//     String? id,
//     String? isSpam,
//     SpamMessage? spamMessage,
//     String? score,
//     SendreceiveDatetime? sendreceiveDatetime,
//   }) =>
//       SmsLogDetail(
//         smsLogDetailId: smsLogDetailId ?? this.smsLogDetailId,
//         address: address ?? this.address,
//         body: body ?? this.body,
//         isRead: isRead ?? this.isRead,
//         messageState: messageState ?? this.messageState,
//         messageKind: messageKind ?? this.messageKind,
//         queryKind: queryKind ?? this.queryKind,
//         date: date ?? this.date,
//         threadId: threadId ?? this.threadId,
//         id: id ?? this.id,
//         isSpam: isSpam ?? this.isSpam,
//         spamMessage: spamMessage ?? this.spamMessage,
//         score: score ?? this.score,
//         sendreceiveDatetime: sendreceiveDatetime ?? this.sendreceiveDatetime,
//       );

//   factory SmsLogDetail.fromJson(Map<String, dynamic> json) => SmsLogDetail(
//         smsLogDetailId: json["id"],
//         address: json["address"],
//         body: json["body"],
//         isRead: json["is_read"],
//         messageState: messageStateValues.map[json["MessageState"]]!,
//         messageKind: kindValues.map[json["MessageKind"]]!,
//         queryKind: kindValues.map[json["QueryKind"]]!,
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         threadId: json["thread_id"],
//         id: json["_id"],
//         isSpam: json["is_spam"],
//         spamMessage: spamMessageValues.map[json["spam_message"]]!,
//         score: json["score"],
//         sendreceiveDatetime:
//             sendreceiveDatetimeValues.map[json["sendreceive_datetime"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": smsLogDetailId,
//         "address": address,
//         "body": body,
//         "is_read": isRead,
//         "MessageState": messageStateValues.reverse[messageState],
//         "MessageKind": kindValues.reverse[messageKind],
//         "QueryKind": kindValues.reverse[queryKind],
//         "date": date?.toIso8601String(),
//         "thread_id": threadId,
//         "_id": id,
//         "is_spam": isSpam,
//         "spam_message": spamMessageValues.reverse[spamMessage],
//         "score": score,
//         "sendreceive_datetime":
//             sendreceiveDatetimeValues.reverse[sendreceiveDatetime],
//       };
// }

// enum Kind { EMPTY, SENT }

// final kindValues = EnumValues({"": Kind.EMPTY, "sent": Kind.SENT});

// enum MessageState { NONE }

// final messageStateValues = EnumValues({"none": MessageState.NONE});

// enum SendreceiveDatetime {
//   FRIDAY_11_APR_2025,
//   SATURDAY_19_APR_2025,
//   THE_1905,
//   THURSDAY_30_JAN_2025
// }

// final sendreceiveDatetimeValues = EnumValues({
//   "Friday, 11 Apr 2025": SendreceiveDatetime.FRIDAY_11_APR_2025,
//   "Saturday, 19 Apr 2025": SendreceiveDatetime.SATURDAY_19_APR_2025,
//   "19:05": SendreceiveDatetime.THE_1905,
//   "Thursday, 30 Jan 2025": SendreceiveDatetime.THURSDAY_30_JAN_2025
// });

// enum SpamMessage { EMPTY, THIS_MESSAGE_IS_LIKELY_SPAM }

// final spamMessageValues = EnumValues({
//   "": SpamMessage.EMPTY,
//   "This message is likely spam": SpamMessage.THIS_MESSAGE_IS_LIKELY_SPAM
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
