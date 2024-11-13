// To parse this JSON data, do
//
//     final corporateResponse = corporateResponseFromJson(jsonString);

import 'dart:convert';

CorporateResponse corporateResponseFromJson(String str) => CorporateResponse.fromJson(json.decode(str));

String corporateResponseToJson(CorporateResponse data) => json.encode(data.toJson());

class CorporateResponse {
  final int? statusCode;
  final String? message;
  final Data? data;

  CorporateResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory CorporateResponse.fromJson(Map<String, dynamic> json) => CorporateResponse(
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
  final dynamic userName;
  final String? firstName;
  final dynamic lastName;
  final String? email;
  final dynamic countryCode;
  final String? phone;
  final String? userRole;
  final String? crn;
  final String? corporateId;
  final String? isEmailVerify;
  final String? photo;
  final String? supportPin;
  final dynamic gender;
  final dynamic dob;
  final dynamic countryId;
  final dynamic state;
  final dynamic city;
  final dynamic zip;
  final dynamic address;
  final dynamic address2;
  final String? country;
  final String? token;

  Data({
    this.userId,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phone,
    this.userRole,
    this.crn,
    this.corporateId,
    this.isEmailVerify,
    this.photo,
    this.supportPin,
    this.gender,
    this.dob,
    this.countryId,
    this.state,
    this.city,
    this.zip,
    this.address,
    this.address2,
    this.country,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    userName: json["user_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    countryCode: json["country_code"],
    phone: json["phone"],
    userRole: json["user_role"],
    crn: json["crn"],
    corporateId: json["corporate_id"],
    isEmailVerify: json["is_email_verify"],
    photo: json["photo"],
    supportPin: json["support_pin"],
    gender: json["gender"],
    dob: json["dob"],
    countryId: json["country_id"],
    state: json["state"],
    city: json["city"],
    zip: json["zip"],
    address: json["address"],
    address2: json["address2"],
    country: json["country"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "country_code": countryCode,
    "phone": phone,
    "user_role": userRole,
    "crn": crn,
    "corporate_id": corporateId,
    "is_email_verify": isEmailVerify,
    "photo": photo,
    "support_pin": supportPin,
    "gender": gender,
    "dob": dob,
    "country_id": countryId,
    "state": state,
    "city": city,
    "zip": zip,
    "address": address,
    "address2": address2,
    "country": country,
    "token": token,
  };
}
