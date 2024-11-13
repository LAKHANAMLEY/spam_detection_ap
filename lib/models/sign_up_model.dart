// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  final int? statusCode;
  final dynamic message;
  final Data? data;

  SignUpResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  SignUpResponse copyWith({
    int? statusCode,
    dynamic message,
    Data? data,
  }) =>
      SignUpResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
  final String? lastName;
  final String? email;
  final String? phone;
  final String? userRole;
  final String? isEmailVerify;
  final String? photo;
  final String? supportPin;
  final dynamic gender;
  final DateTime? dob;
  final String? countryId;
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
    this.phone,
    this.userRole,
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
    phone: json["phone"],
    userRole: json["user_role"],
    isEmailVerify: json["is_email_verify"],
    photo: json["photo"],
    supportPin: json["support_pin"],
    gender: json["gender"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
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
    "phone": phone,
    "user_role": userRole,
    "is_email_verify": isEmailVerify,
    "photo": photo,
    "support_pin": supportPin,
    "gender": gender,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
