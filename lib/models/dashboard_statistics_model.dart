// To parse this JSON data, do
//
//     final dashboardStatisticsResponse = dashboardStatisticsResponseFromJson(jsonString);

import 'dart:convert';

DashboardStatisticsResponse dashboardStatisticsResponseFromJson(String str) =>
    DashboardStatisticsResponse.fromJson(json.decode(str));

String dashboardStatisticsResponseToJson(DashboardStatisticsResponse data) =>
    json.encode(data.toJson());

class DashboardStatisticsResponse {
  final int? statusCode;
  final StatisticsDashboardData? statisticsDashboardData;

  DashboardStatisticsResponse({
    this.statusCode,
    this.statisticsDashboardData,
  });

  factory DashboardStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      DashboardStatisticsResponse(
        statusCode: json["status_code"],
        statisticsDashboardData: json["statistics_dashboard_data"] == null
            ? null
            : StatisticsDashboardData.fromJson(
                json["statistics_dashboard_data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "statistics_dashboard_data": statisticsDashboardData?.toJson(),
      };
}

class StatisticsDashboardData {
  final int? totalSpamCalls;
  final String? timeSavedFromSpammers;
  final int? unknownNumber;
  final int? messageMovedToSpam;

  StatisticsDashboardData({
    this.totalSpamCalls,
    this.timeSavedFromSpammers,
    this.unknownNumber,
    this.messageMovedToSpam,
  });

  factory StatisticsDashboardData.fromJson(Map<String, dynamic> json) =>
      StatisticsDashboardData(
        totalSpamCalls: json["total_spam_calls"],
        timeSavedFromSpammers: json["time_saved_from_spammers"],
        unknownNumber: json["unknown_number"],
        messageMovedToSpam: json["message_moved_to_spam"],
      );

  Map<String, dynamic> toJson() => {
        "total_spam_calls": totalSpamCalls,
        "time_saved_from_spammers": timeSavedFromSpammers,
        "unknown_number": unknownNumber,
        "message_moved_to_spam": messageMovedToSpam,
      };
}
