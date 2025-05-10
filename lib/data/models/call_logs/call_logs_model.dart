// To parse this JSON data, do
//
//     final callLogsListResponse = callLogsListResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/utils/call_type_helper/call_type_helpers.dart';

CallLogsListResponse callLogsListResponseFromJson(String str) =>
    CallLogsListResponse.fromJson(json.decode(str));

String callLogsListResponseToJson(CallLogsListResponse data) =>
    json.encode(data.toJson());

class CallLogsListResponse {
  final int? statusCode;
  final List<CallLogData>? callloglist;
  final String? message;

  CallLogsListResponse({this.statusCode, this.callloglist, this.message});

  CallLogsListResponse copyWith({
    int? statusCode,
    List<CallLogData>? callloglist,
    String? message,
  }) =>
      CallLogsListResponse(
        statusCode: statusCode ?? this.statusCode,
        callloglist: callloglist ?? this.callloglist,
      );

  factory CallLogsListResponse.fromJson(Map<String, dynamic> json) =>
      CallLogsListResponse(
        statusCode: json["status_code"],
        callloglist: json["callloglist"] == null
            ? []
            : List<CallLogData>.from(
                json["callloglist"]!.map((x) => CallLogData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "callloglist": callloglist == null
            ? []
            : List<dynamic>.from(callloglist!.map((x) => x.toJson())),
        "message": message,
      };
}

class CallLogData {
  final String? id;
  final String? phoneaccountid;
  final String? simdisplayname;
  final String? name;
  final String? callType;
  final String? countryCode;
  final String? mobileNo;
  final DateTime? callTime;
  final String? callDuration;
  final String? callDurationUnit;
  final String? contactListId;
  final String? callDurations;
  final int? isSpam;
  final int? isBlocked;
  final int? markSpamByUser;
  final String isManually;
  final bool synced;
  final bool isMarkSpamByMe;

  //Add new params from contactData here
  final ContactData? contactData;

  CallLogData({
    this.id,
    this.phoneaccountid,
    this.simdisplayname,
    this.name,
    this.callType,
    this.countryCode,
    this.mobileNo,
    this.callTime,
    this.callDuration,
    this.callDurationUnit,
    this.contactListId,
    this.callDurations,
    this.isSpam,
    this.isBlocked,
    this.markSpamByUser,
    this.isManually = "0",
    this.contactData,
    this.synced = false,
    this.isMarkSpamByMe = false,
  });

  CallLogData copyWith({
    String? totalcalllog,
    String? id,
    String? phoneaccountid,
    String? simdisplayname,
    String? name,
    String? callType,
    String? countryCode,
    String? mobileNo,
    DateTime? callTime,
    String? callDuration,
    String? callDurationUnit,
    String? contactListId,
    int? isSpam,
    int? markspambyuser,
    int? isBlocked,
    String? callDurations,
    String? isManually,
    ContactData? contactData,
    bool? synced,
    bool? isMarkedSpamByMe,
  }) =>
      CallLogData(
        // totalcalllog: totalcalllog ?? this.totalcalllog,
        id: id ?? this.id,
        phoneaccountid: phoneaccountid ?? this.phoneaccountid,
        simdisplayname: simdisplayname ?? this.simdisplayname,
        name: name ?? this.name,
        callType: callType ?? this.callType,
        countryCode: countryCode ?? this.countryCode,
        mobileNo: mobileNo ?? this.mobileNo,
        callTime: callTime ?? this.callTime,
        callDuration: callDuration ?? this.callDuration,
        callDurationUnit: callDurationUnit ?? this.callDurationUnit,
        contactListId: contactListId ?? this.contactListId,
        isSpam: isSpam ?? this.isSpam,
        markSpamByUser: markspambyuser ?? markSpamByUser,
        isBlocked: isBlocked ?? this.isBlocked,
        callDurations: callDurations ?? this.callDurations,
        isManually: isManually ?? this.isManually,
        contactData: contactData ?? this.contactData,
        synced: synced ?? this.synced,
        isMarkSpamByMe: isMarkedSpamByMe ?? this.isMarkSpamByMe,
      );

  factory CallLogData.fromJson(Map<String, dynamic> json) => CallLogData(
        id: json["id"],
        phoneaccountid: json["phoneaccountid"].runtimeType == int
            ? json["phoneaccountid"].toString()
            : json["phoneaccountid"],
        simdisplayname: json["simdisplayname"],
        name: json["name"],
        callType: json["call_type"],
        countryCode: json["country_code"],
        mobileNo: json["mobile_no"],
        callTime: (json["call_time"]?.toString().isEmpty ?? true)
            ? null
            : DateTime.tryParse(json["call_time"]),
        callDuration: json["call_duration"],
        callDurationUnit: json["call_duration_unit"],
        contactListId: json["contact_list_id"] is int
            ? json["contact_list_id"].toString()
            : json["contact_list_id"],
        callDurations: json["call_durations"],
        isSpam: json["is_spam"],
        isBlocked: json["is_blocked"],
        markSpamByUser: json["markspambyuser"],
        contactData: json["contact_data"] == null
            ? null
            : ContactData.fromJson(json["contact_data"]),
        synced: json["synced"] == 1,
        isMarkSpamByMe: json["markspambyme"] == 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phoneaccountid": phoneaccountid,
        "simdisplayname": simdisplayname,
        "name": name,
        "call_type": callType,
        "country_code": countryCode,
        "mobile_no": mobileNo,
        "call_time": callTime?.toIso8601String(),
        "call_duration": callDuration,
        "call_duration_unit": callDurationUnit,
        "contact_list_id": contactListId,
        "call_durations": callDurations,
        "is_spam": isSpam,
        "is_blocked": isBlocked,
        "markspambyuser": markSpamByUser,
        "contactData": contactData?.toJson(),
        "synced": synced,
        "ismarkbyme": isMarkSpamByMe,
      };

  // static CallLogData? fromContact(ContactData? contact) =>
  //     contact?.callHistory?.firstOrNull;

  static CallLogData? fromContact(ContactData? contact) => CallLogData(
        id: contact?.id,
        contactListId: contact?.id,
        countryCode: contact?.countryCode,
        mobileNo: contact?.mobileNo,
        name: contact?.name,
        isSpam: contact?.isSpam,
        isBlocked: contact?.isBlocked,
        markSpamByUser: contact?.markspambyuser,
        // phoneaccountid: contact?.id,
      );

  static CallLogData fromCallLogEntry(CallLogEntry callLog) => CallLogData(
        id: callLog.number?.separatePhoneAndPhoneCode().phone,
        countryCode: callLog.number?.separatePhoneAndPhoneCode().phoneCode,
        mobileNo: callLog.number?.separatePhoneAndPhoneCode().phone,
        name: callLog.name,
        callDuration: callLog.duration.toString(),
        callDurations: callLog.duration.toString(),
        callDurationUnit: "1",
        callTime: callLog.timestamp?.toDateTime(),
        callType: callLog.callType?.name,
        isManually: "1",
        contactListId: callLog.phoneAccountId,
        phoneaccountid: callLog.phoneAccountId,
        simdisplayname: callLog.simDisplayName,
        synced: false,
        isMarkSpamByMe: false,

        ///other details will update from server
      );

  CallLogEntry toCallLogEntry() => CallLogEntry(
        number: mobileNo,
        name: name,
        callType: CallTypeHelper.getCallLogType(callType),
        duration: int.tryParse(callDuration ?? ""),
        timestamp: callTime?.millisecondsSinceEpoch,
        simDisplayName: simdisplayname,
        phoneAccountId: phoneaccountid,
        formattedNumber: mobileNo,
      );
}
