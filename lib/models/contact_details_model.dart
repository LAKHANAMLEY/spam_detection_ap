// To parse this JSON data, do
//
//     final contactDetailsResponse = contactDetailsResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

ContactDetailsResponse contactDetailsResponseFromJson(String str) =>
    ContactDetailsResponse.fromJson(json.decode(str));

String contactDetailsResponseToJson(ContactDetailsResponse data) =>
    json.encode(data.toJson());

class ContactDetailsResponse {
  final int? statusCode;
  final String? message;
  final ContactData? contactdetails;

  ContactDetailsResponse({
    this.statusCode,
    this.message,
    this.contactdetails,
  });

  ContactDetailsResponse copyWith({
    int? statusCode,
    String? message,
    ContactData? contactdetails,
  }) =>
      ContactDetailsResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        contactdetails: contactdetails ?? this.contactdetails,
      );

  factory ContactDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ContactDetailsResponse(
        statusCode: json["status_code"],
        message: json["message"],
        contactdetails: json["contactdetails"] == null
            ? null
            : ContactData.fromJson(json["contactdetails"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "contactdetails": contactdetails?.toJson(),
      };
}
