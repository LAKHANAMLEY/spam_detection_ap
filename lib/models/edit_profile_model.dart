// To parse this JSON data, do
//
//     final editProfileResponse = editProfileResponseFromJson(jsonString);

import 'dart:convert';

EditProfileResponse editProfileResponseFromJson(String str) => EditProfileResponse.fromJson(json.decode(str));

String editProfileResponseToJson(EditProfileResponse data) => json.encode(data.toJson());

class EditProfileResponse {
  final int? statusCode;
  final String? message;
  final Data? data;

  EditProfileResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) => EditProfileResponse(
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
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? phone;
  final String? userRole;
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
  final String? name;
  final String? country;

  Data({
    this.userId,
    this.lastName,
    this.email,
    this.countryCode,
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
    this.name,
    this.country,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    lastName: json["last_name"],
    email: json["email"],
    countryCode: json["country_code"],
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
    name: json["name"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "last_name": lastName,
    "email": email,
    "country_code": countryCode,
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
    "name": name,
    "country": country,
  };
}
