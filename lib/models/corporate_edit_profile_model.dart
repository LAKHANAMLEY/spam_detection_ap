// To parse this JSON data, do
//
//     final corporateEditProfileResponse = corporateEditProfileResponseFromJson(jsonString);

import '../lib.dart';

CorporateEditProfileResponse corporateEditProfileResponseFromJson(String str) =>
    CorporateEditProfileResponse.fromJson(json.decode(str));

String corporateEditProfileResponseToJson(CorporateEditProfileResponse data) =>
    json.encode(data.toJson());

class CorporateEditProfileResponse {
  final int? statusCode;
  final String? message;
  final CorporateData? data;

  CorporateEditProfileResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory CorporateEditProfileResponse.fromJson(Map<String, dynamic> json) =>
      CorporateEditProfileResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data:
            json["data"] == null ? null : CorporateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class CorporateData {
  final String? userId;
  final String? uName;
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
  final XFile? photoFile;

  CorporateData({
    this.userId,
    this.uName,
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
    this.photoFile,
  });

  factory CorporateData.fromJson(Map<String, dynamic> json) => CorporateData(
        userId: json["user_id"],
        uName: json["u_name"],
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
        "u_name": uName,
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
