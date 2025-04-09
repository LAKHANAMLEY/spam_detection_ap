// To parse this JSON data, do
//
//     final transactionHistoryDetailsResponse = transactionHistoryDetailsResponseFromJson(jsonString);

import 'dart:convert';

TransactionHistoryDetailsResponse transactionHistoryDetailsResponseFromJson(
        String str) =>
    TransactionHistoryDetailsResponse.fromJson(json.decode(str));

String transactionHistoryDetailsResponseToJson(
        TransactionHistoryDetailsResponse data) =>
    json.encode(data.toJson());

class TransactionHistoryDetailsResponse {
  final int? statusCode;
  final List<TransactionData>? transactionHistory;

  TransactionHistoryDetailsResponse({
    this.statusCode,
    this.transactionHistory,
  });

  factory TransactionHistoryDetailsResponse.fromJson(
          Map<String, dynamic> json) =>
      TransactionHistoryDetailsResponse(
        statusCode: json["status_code"],
        transactionHistory: json["transaction_history"] == null
            ? []
            : List<TransactionData>.from(json["transaction_history"]!
                .map((x) => TransactionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "transaction_history": transactionHistory == null
            ? []
            : List<dynamic>.from(transactionHistory!.map((x) => x.toJson())),
      };
}

class TransactionData {
  final String? id;
  final String? planId;
  final String? planCode;
  final String? title;
  final String? price;
  final String? status;
  final String? transactionId;
  final String? cancelledAt;
  final String? expiredAt;

  TransactionData({
    this.id,
    this.planId,
    this.planCode,
    this.title,
    this.price,
    this.status,
    this.transactionId,
    this.cancelledAt,
    this.expiredAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        id: json["id"],
        planId: json["plan_id"],
        planCode: json["plan_code"],
        title: json["title"],
        price: json["price"],
        status: json["status"],
        transactionId: json["transaction_id"],
        cancelledAt: json["cancelled_at"],
        expiredAt: json["expired_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan_id": planId,
        "plan_code": planCode,
        "title": title,
        "price": price,
        "status": status,
        "transaction_id": transactionId,
        "cancelled_at": cancelledAt,
        "expired_at": expiredAt,
      };
}
