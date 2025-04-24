// To parse this JSON data, do
//
//     final contactListResponse = contactListResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

ContactListResponse contactListResponseFromJson(String str) =>
    ContactListResponse.fromJson(json.decode(str));

String contactListResponseToJson(ContactListResponse data) =>
    json.encode(data.toJson());

class ContactListResponse {
  final int? statusCode;
  final List<ContactData>? contactslist;
  final String? message;

  ContactListResponse({this.statusCode, this.contactslist, this.message});

  ContactListResponse copyWith({
    int? statusCode,
    List<ContactData>? contactslist,
  }) =>
      ContactListResponse(
        statusCode: statusCode ?? this.statusCode,
        contactslist: contactslist ?? this.contactslist,
      );

  factory ContactListResponse.fromJson(Map<String, dynamic> json) =>
      ContactListResponse(
        statusCode: json["status_code"],
        contactslist: json["contactslist"] == null
            ? []
            : List<ContactData>.from(
                json["contactslist"]!.map((x) => ContactData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "contactslist": contactslist == null
            ? []
            : List<dynamic>.from(contactslist!.map((x) => x.toJson())),
        "message": message
      };
}

// class ContactData {
//   final String? id;
//   final String? name;
//   final String? countryCode;
//   final String? mobileNo;
//   final String? email;
//   final String? numberType;
//   final int? isSpam;
//   final int? markspambyuser;
//   final int? isBlocked;
//   final String? spamReport;
//   final String? callActivity;
//   final String? usuallyCalls;
//   final String? lastSeen;
//   final List<dynamic>? callHistory;

//   ContactData({
//     this.id,
//     this.name,
//     this.countryCode,
//     this.mobileNo,
//     this.email,
//     this.numberType,
//     this.isSpam,
//     this.markspambyuser,
//     this.isBlocked,
//     this.spamReport,
//     this.callActivity,
//     this.usuallyCalls,
//     this.lastSeen,
//     this.callHistory,
//   });

//   factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
//         id: json["id"],
//         name: json["name"],
//         countryCode: json["country_code"],
//         mobileNo: json["mobile_no"],
//         email: json["email"],
//         numberType: json["number_type"],
//         isSpam: json["is_spam"],
//         markspambyuser: json["markspambyuser"],
//         isBlocked: json["is_blocked"],
//         spamReport: json["spam_report"],
//         callActivity: json["call_activity"],
//         usuallyCalls: json["usually_calls"],
//         lastSeen: json["last_seen"],
//         callHistory: json["call_history"] == null
//             ? []
//             : List<dynamic>.from(json["call_history"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "country_code": countryCode,
//         "mobile_no": mobileNo,
//         "email": email,
//         "number_type": numberType,
//         "is_spam": isSpam,
//         "markspambyuser": markspambyuser,
//         "is_blocked": isBlocked,
//         "spam_report": spamReport,
//         "call_activity": callActivity,
//         "usually_calls": usuallyCalls,
//         "last_seen": lastSeen,
//         "call_history": callHistory == null
//             ? []
//             : List<dynamic>.from(callHistory!.map((x) => x)),
//       };
// }

class ContactData {
  final String? id;
  final String? name;
  final String? countryCode;
  final String? numberType;
  final String? mobileNo;
  final int? isSpam;
  final String? category;
  final int? markspambyuser;
  final String? isRegistered;
  final int? isBlocked;
  final String? spamReport;
  final String? callActivity;
  final String? usuallyCalls;
  final String? lastSeen;
  final String? isOnline;
  final List<CallLogData>? callHistory;
  final String? email;

  ContactData({
    this.id,
    this.name,
    this.countryCode,
    this.numberType,
    this.mobileNo,
    this.isSpam,
    this.category,
    this.markspambyuser,
    this.isRegistered,
    this.isBlocked,
    this.spamReport,
    this.callActivity,
    this.usuallyCalls,
    this.lastSeen,
    this.isOnline,
    this.callHistory,
    this.email,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        numberType: json["number_type"],
        mobileNo: json["mobile_no"],
        isSpam: json["is_spam"],
        category: json["category"],
        markspambyuser: json["markspambyuser"],
        isRegistered: json["is_registered"].toString(),
        isBlocked: json["is_blocked"],
        spamReport: json["spam_report"],
        callActivity: json["call_activity"],
        usuallyCalls: json["usually_calls"],
        lastSeen: json["last_seen"],
        isOnline: json["is_online"].toString(),
        callHistory: json["call_history"] == null
            ? []
            : List<CallLogData>.from(
                json["call_history"]!.map((x) => CallLogData.fromJson(x)),
              ),
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "number_type": numberType,
        "mobile_no": mobileNo,
        "is_spam": isSpam,
        "category": category,
        "markspambyuser": markspambyuser,
        "is_registered": isRegistered,
        "is_blocked": isBlocked,
        "spam_report": spamReport,
        "call_activity": callActivity,
        "usually_calls": usuallyCalls,
        "last_seen": lastSeen,
        "is_online": isOnline,
        "call_history": callHistory == null
            ? []
            : List<dynamic>.from(callHistory!.map((x) => x.toJson())),
        "email": email,
      };
}

// class CallHistory {
//   final String? id;
//   final String? phoneaccountid;
//   final String? simdisplayname;
//   final String? name;
//   final String? callType;
//   final String? countryCode;
//   final String? mobileNo;
//   final DateTime? callTime;
//   final String? callDuration;
//   final String? callDurationUnit;
//   final String? contactListId;
//   final String? callDurations;

//   CallHistory({
//     this.id,
//     this.phoneaccountid,
//     this.simdisplayname,
//     this.name,
//     this.callType,
//     this.countryCode,
//     this.mobileNo,
//     this.callTime,
//     this.callDuration,
//     this.callDurationUnit,
//     this.contactListId,
//     this.callDurations,
//   });

//   factory CallHistory.fromJson(Map<String, dynamic> json) => CallHistory(
//         id: json["id"],
//         phoneaccountid: json["phoneaccountid"],
//         simdisplayname: json["simdisplayname"],
//         name: json["name"],
//         callType: json["call_type"],
//         countryCode: json["country_code"],
//         mobileNo: json["mobile_no"],
//         callTime: json["call_time"] == null
//             ? null
//             : DateTime.parse(json["call_time"]),
//         callDuration: json["call_duration"],
//         callDurationUnit: json["call_duration_unit"],
//         contactListId: json["contact_list_id"],
//         callDurations: json["call_durations"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "phoneaccountid": phoneaccountid,
//         "simdisplayname": simdisplayname,
//         "name": name,
//         "call_type": callType,
//         "country_code": countryCode,
//         "mobile_no": mobileNo,
//         "call_time": callTime?.toIso8601String(),
//         "call_duration": callDuration,
//         "call_duration_unit": callDurationUnit,
//         "contact_list_id": contactListId,
//         "call_durations": callDurations,
//       };
// }
