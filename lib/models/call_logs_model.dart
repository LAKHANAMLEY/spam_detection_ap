// To parse this JSON data, do
//
//     final callLogsListResponse = callLogsListResponseFromJson(jsonString);

import 'dart:convert';

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
  final String? mobileNo;
  final DateTime? callTime;
  final String? callDuration;
  final String? callDurationUnit;
  final String? contactListId;
  final String? callDurations;

  CallLogData({
    this.id,
    this.phoneaccountid,
    this.simdisplayname,
    this.name,
    this.callType,
    this.mobileNo,
    this.callTime,
    this.callDuration,
    this.callDurationUnit,
    this.contactListId,
    this.callDurations,
  });

  CallLogData copyWith({
    String? id,
    String? phoneaccountid,
    String? simdisplayname,
    String? name,
    String? callType,
    String? mobileNo,
    DateTime? callTime,
    String? callDuration,
    String? callDurationUnit,
    String? contactListId,
    String? callDurations,
  }) =>
      CallLogData(
        id: id ?? this.id,
        phoneaccountid: phoneaccountid ?? this.phoneaccountid,
        simdisplayname: simdisplayname ?? this.simdisplayname,
        name: name ?? this.name,
        callType: callType ?? this.callType,
        mobileNo: mobileNo ?? this.mobileNo,
        callTime: callTime ?? this.callTime,
        callDuration: callDuration ?? this.callDuration,
        callDurationUnit: callDurationUnit ?? this.callDurationUnit,
        contactListId: contactListId ?? this.contactListId,
        callDurations: callDurations ?? this.callDurations,
      );

  factory CallLogData.fromJson(Map<String, dynamic> json) => CallLogData(
        id: json["id"],
        phoneaccountid: json["phoneaccountid"],
        simdisplayname: json["simdisplayname"],
        name: json["name"],
        callType: json["call_type"],
        mobileNo: json["mobile_no"],
        callTime: json["call_time"] == null
            ? null
            : DateTime.parse(json["call_time"]),
        callDuration: json["call_duration"],
        callDurationUnit: json["call_duration_unit"],
        contactListId: json["contact_list_id"],
        callDurations: json["call_durations"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phoneaccountid": phoneaccountid,
        "simdisplayname": simdisplayname,
        "name": name,
        "call_type": callType,
        "mobile_no": mobileNo,
        "call_time": callTime?.toIso8601String(),
        "call_duration": callDuration,
        "call_duration_unit": callDurationUnit,
        "contact_list_id": contactListId,
        "call_durations": callDurations,
      };
}
