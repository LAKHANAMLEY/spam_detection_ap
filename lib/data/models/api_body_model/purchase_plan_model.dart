// To parse this JSON data, do
//
//     final purchasePlanModel = purchasePlanModelFromJson(jsonString);

import 'dart:convert';

PurchasePlanModel purchasePlanModelFromJson(String str) =>
    PurchasePlanModel.fromJson(json.decode(str));

String purchasePlanModelToJson(PurchasePlanModel data) =>
    json.encode(data.toJson());

class PurchasePlanModel {
  final String? planId;
  final String? transactionId;

  PurchasePlanModel({
    this.planId,
    this.transactionId,
  });

  factory PurchasePlanModel.fromJson(Map<String, dynamic> json) =>
      PurchasePlanModel(
        planId: json["plan_id"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "transaction_id": transactionId,
      };
}
