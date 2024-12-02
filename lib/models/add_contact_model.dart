// To parse this JSON data, do
//
//     final addContactResponse = addContactResponseFromJson(jsonString);

import 'dart:convert';

AddContactResponse addContactResponseFromJson(String str) =>
    AddContactResponse.fromJson(json.decode(str));

String addContactResponseToJson(AddContactResponse data) =>
    json.encode(data.toJson());

class AddContactResponse {
  final int? statusCode;
  final String? message;

  AddContactResponse({
    this.statusCode,
    this.message,
  });

  factory AddContactResponse.fromJson(Map<String, dynamic> json) =>
      AddContactResponse(
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
      };
}
