// To parse this JSON data, do
//
//     final callLogListResponse = callLogListResponseFromJson(jsonString);

import 'dart:convert';

CallLogListResponse callLogListResponseFromJson(String str) => CallLogListResponse.fromJson(json.decode(str));

String callLogListResponseToJson(CallLogListResponse data) => json.encode(data.toJson());

class CallLogListResponse {
  final int? statusCode;
  final List<Callloglist>? callloglist;

  CallLogListResponse({
    this.statusCode,
    this.callloglist,
  });

  factory CallLogListResponse.fromJson(Map<String, dynamic> json) => CallLogListResponse(
    statusCode: json["status_code"],
    callloglist: json["callloglist"] == null ? [] : List<Callloglist>.from(json["callloglist"]!.map((x) => Callloglist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "callloglist": callloglist == null ? [] : List<dynamic>.from(callloglist!.map((x) => x.toJson())),
  };
}

class Callloglist {
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

  Callloglist({
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

  factory Callloglist.fromJson(Map<String, dynamic> json) => Callloglist(
    id: json["id"],
    phoneaccountid: json["phoneaccountid"],
    simdisplayname: json["simdisplayname"],
    name: json["name"],
    callType: json["call_type"],
    mobileNo: json["mobile_no"],
    callTime: json["call_time"] == null ? null : DateTime.parse(json["call_time"]),
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
