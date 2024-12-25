// To parse this JSON data, do
//
//     final syncCallManuallyResponse = syncCallManuallyResponseFromJson(jsonString);

import 'dart:convert';

SyncCallManuallyResponse syncCallManuallyResponseFromJson(String str) =>
    SyncCallManuallyResponse.fromJson(json.decode(str));

String syncCallManuallyResponseToJson(SyncCallManuallyResponse data) =>
    json.encode(data.toJson());

class SyncCallManuallyResponse {
  final int? statusCode;
  final String? message;
  final CallLog? callLog;

  SyncCallManuallyResponse({
    this.statusCode,
    this.message,
    this.callLog,
  });

  factory SyncCallManuallyResponse.fromJson(Map<String, dynamic> json) =>
      SyncCallManuallyResponse(
        statusCode: json["status_code"],
        message: json["message"],
        callLog: json["call_log"] == null
            ? null
            : CallLog.fromJson(json["call_log"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "call_log": callLog?.toJson(),
      };
}

class CallLog {
  final String? userId;
  final String? name;
  final String? simdisplayname;
  final String? phoneaccountid;
  final String? mobileNo;
  final int? contactListId;
  final String? callType;
  final DateTime? callTime;
  final String? countryCode;
  final String? callDuration;
  final String? callDurationUnit;

  CallLog({
    this.userId,
    this.name,
    this.simdisplayname,
    this.phoneaccountid,
    this.mobileNo,
    this.contactListId,
    this.callType,
    this.callTime,
    this.countryCode,
    this.callDuration,
    this.callDurationUnit,
  });

  factory CallLog.fromJson(Map<String, dynamic> json) => CallLog(
        userId: json["user_id"],
        name: json["name"],
        simdisplayname: json["simdisplayname"],
        phoneaccountid: json["phoneaccountid"],
        mobileNo: json["mobile_no"],
        contactListId: json["contact_list_id"],
        callType: json["call_type"],
        callTime: json["call_time"] == null
            ? null
            : DateTime.parse(json["call_time"]),
        countryCode: json["country_code"],
        callDuration: json["call_duration"],
        callDurationUnit: json["call_duration_unit"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "simdisplayname": simdisplayname,
        "phoneaccountid": phoneaccountid,
        "mobile_no": mobileNo,
        "contact_list_id": contactListId,
        "call_type": callType,
        "call_time": callTime?.toIso8601String(),
        "country_code": countryCode,
        "call_duration": callDuration,
        "call_duration_unit": callDurationUnit,
      };
}
