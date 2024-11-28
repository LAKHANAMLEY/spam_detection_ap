// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:image_picker/image_picker.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final int? statusCode;
  final dynamic message;
  final User? data;

  LoginResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  LoginResponse copyWith({
    int? statusCode,
    dynamic message,
    User? data,
  }) =>
      LoginResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class User {
  final String? userId;
  final String? userName;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? userRole;
  final String? countryCode;
  final String? crn;
  final String? corporateId;
  final String? isEmailVerify;
  final String? photo;
  final String? supportPin;
  final String? gender;
  final DateTime? dob;
  final String? countryId;
  final String? state;
  final String? city;
  final String? zip;
  final String? address;
  final String? address2;
  final String? country;
  final String? token;
  final XFile? photoFile;

  User(
      {this.userId,
      this.userName,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.userRole,
      this.countryCode,
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
      this.photoFile});

  User copyWith({
    String? userId,
    String? userName,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? userRole,
    dynamic countryCode,
    String? crn,
    String? corporateId,
    String? isEmailVerify,
    String? photo,
    String? supportPin,
    dynamic gender,
    DateTime? dob,
    String? countryId,
    dynamic state,
    dynamic city,
    dynamic zip,
    dynamic address,
    dynamic address2,
    String? country,
    String? token,
  }) =>
      User(
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        userRole: userRole ?? this.userRole,
        countryCode: countryCode ?? this.countryCode,
        crn: crn ?? this.crn,
        corporateId: corporateId ?? corporateId,
        isEmailVerify: isEmailVerify ?? this.isEmailVerify,
        photo: photo ?? this.photo,
        supportPin: supportPin ?? this.supportPin,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        countryId: countryId ?? this.countryId,
        state: state ?? this.state,
        city: city ?? this.city,
        zip: zip ?? this.zip,
        address: address ?? this.address,
        address2: address2 ?? this.address2,
        country: country ?? this.country,
        token: token ?? this.token,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        userRole: json["user_role"],
        countryCode: json["country_code"],
        crn: json["crn"],
        corporateId: json["corporate_id"],
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
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "user_role": userRole,
        "country_code": countryCode,
        "crn": crn,
        "corporate_id": corporateId,
        "is_email_verify": isEmailVerify,
        "photo": photo,
        "support_pin": supportPin,
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
