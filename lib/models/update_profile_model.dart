
// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  final int? statusCode;
  final String? message;
  final Data? data;

  UpdateProfileResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? userId;
  final String? email;
  final String? phone;
  final String? userRole;
  final String? company;
  final String? crn;
  final String? corporateId;
  final String? isEmailVerify;
  final String? photo;
  final String? supportPin;
  final String? name;

  Data({
    this.userId,
    this.email,
    this.phone,
    this.userRole,
    this.company,
    this.crn,
    this.corporateId,
    this.isEmailVerify,
    this.photo,
    this.supportPin,
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    email: json["email"],
    phone: json["phone"],
    userRole: json["user_role"],
    company: json["company"],
    crn: json["crn"],
    corporateId: json["corporate_id"],
    isEmailVerify: json["is_email_verify"],
    photo: json["photo"],
    supportPin: json["support_pin"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "phone": phone,
    "user_role": userRole,
    "company": company,
    "crn": crn,
    "corporate_id": corporateId,
    "is_email_verify": isEmailVerify,
    "photo": photo,
    "support_pin": supportPin,
    "name": name,
  };
}
