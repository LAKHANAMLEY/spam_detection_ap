// To parse this JSON data, do
//
//     final contactListResponse = contactListResponseFromJson(jsonString);

import 'package:spam_delection_app/lib.dart';

ContactListResponse contactListResponseFromJson(String str) =>
    ContactListResponse.fromJson(json.decode(str));

String contactListResponseToJson(ContactListResponse data) =>
    json.encode(data.toJson());

class ContactListResponse {
  final int? statusCode;
  final List<ContactData>? contactslist;
  final String? message;

  ContactListResponse({this.statusCode, this.contactslist, this.message});

  ContactListResponse copyWith({
    int? statusCode,
    List<ContactData>? contactslist,
  }) =>
      ContactListResponse(
        statusCode: statusCode ?? this.statusCode,
        contactslist: contactslist ?? this.contactslist,
      );

  factory ContactListResponse.fromJson(Map<String, dynamic> json) =>
      ContactListResponse(
        statusCode: json["status_code"],
        contactslist: json["contactslist"] == null
            ? []
            : List<ContactData>.from(
                json["contactslist"]!.map((x) => ContactData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "contactslist": contactslist == null
            ? []
            : List<dynamic>.from(contactslist!.map((x) => x.toJson())),
        "message": message
      };
}

class ContactData {
  final String? id;
  final String? name;
  final String? countryCode;
  final String? numberType;
  final String? mobileNo;
  final int? isSpam;
  final String? category;
  final int? markspambyuser;
  final String? isRegistered;
  final int? isBlocked;
  final String? spamReport;
  final String? callActivity;
  final String? usuallyCalls;
  final String? lastSeen;
  final String? isOnline;
  final List<CallLogData>? callHistory;
  final String? email;
  final bool synced;
  final String? deviceContactId;
  final bool isMarkedSpamByMe;
  final List<SpamComment>? spamComments;

  ContactData({
    this.id,
    this.name,
    this.countryCode,
    this.numberType,
    this.mobileNo,
    this.isSpam,
    this.category,
    this.markspambyuser,
    this.isRegistered,
    this.isBlocked,
    this.spamReport,
    this.callActivity,
    this.usuallyCalls,
    this.lastSeen,
    this.isOnline,
    this.callHistory,
    this.email,
    this.synced = false,
    this.deviceContactId,
    this.isMarkedSpamByMe = false,
    this.spamComments,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        numberType: json["number_type"],
        mobileNo: json["mobile_no"],
        isSpam: json["is_spam"],
        category: json["category"],
        markspambyuser: json["markspambyuser"],
        isRegistered: json["is_registered"].toString(),
        isBlocked: json["is_blocked"],
        spamReport: json["spam_report"],
        callActivity: json["call_activity"],
        usuallyCalls: json["usually_calls"],
        lastSeen: json["last_seen"],
        isOnline: json["is_online"].toString(),
        callHistory: json["call_history"] == null
            ? []
            : List<CallLogData>.from(
                json["call_history"]!.map((x) => CallLogData.fromJson(x)),
              ),
        email: json["email"],
        synced: json["synced"] == 1,
        deviceContactId: json["device_contact_id"],
        isMarkedSpamByMe: json["markspambyme"] == 1,
        spamComments: json["spam_comments"] == null
            ? []
            : List<SpamComment>.from(
                json["spam_comments"]!.map((x) => SpamComment.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "number_type": numberType,
        "mobile_no": mobileNo,
        "is_spam": isSpam,
        "category": category,
        "markspambyuser": markspambyuser,
        "is_registered": isRegistered,
        "is_blocked": isBlocked,
        "spam_report": spamReport,
        "call_activity": callActivity,
        "usually_calls": usuallyCalls,
        "last_seen": lastSeen,
        "is_online": isOnline,
        "call_history": callHistory == null
            ? []
            : List<dynamic>.from(callHistory!.map((x) => x.toJson())),
        "email": email,
        "synced": synced,
        "device_contact_id": deviceContactId,
        "markspambyme": isMarkedSpamByMe,
        "spam_comments": spamComments == null
            ? []
            : List<dynamic>.from(spamComments!.map((x) => x.toJson())),
      };

  ContactData copyWith({
    String? id,
    String? name,
    String? countryCode,
    String? numberType,
    String? mobileNo,
    int? isSpam,
    String? category,
    int? markspambyuser,
    String? isRegistered,
    int? isBlocked,
    String? spamReport,
    String? callActivity,
    String? usuallyCalls,
    String? lastSeen,
    String? isOnline,
    List<CallLogData>? callHistory,
    String? email,
    bool? synced,
    String? deviceContactId,
    bool? isMarkedSpamByMe,
    List<SpamComment>? spamComments,
  }) {
    return ContactData(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      numberType: numberType ?? this.numberType,
      mobileNo: mobileNo ?? this.mobileNo,
      isSpam: isSpam ?? this.isSpam,
      category: category ?? this.category,
      markspambyuser: markspambyuser ?? this.markspambyuser,
      isRegistered: isRegistered ?? this.isRegistered,
      isBlocked: isBlocked ?? this.isBlocked,
      spamReport: spamReport ?? this.spamReport,
      callActivity: callActivity ?? this.callActivity,
      usuallyCalls: usuallyCalls ?? this.usuallyCalls,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
      callHistory: callHistory ?? this.callHistory,
      email: email ?? this.email,
      synced: synced ?? this.synced,
      deviceContactId: deviceContactId ?? this.deviceContactId,
      isMarkedSpamByMe: isMarkedSpamByMe ?? this.isMarkedSpamByMe,
      spamComments: spamComments ?? this.spamComments,
    );
  }

  static ContactData fromContact(Contact e, {ContactData? serverData}) =>
      ContactData(
        id: e.id,
        deviceContactId: e.id,
        countryCode:
            e.phones.firstOrNull?.number.separatePhoneAndPhoneCode().phoneCode,
        mobileNo:
            e.phones.firstOrNull?.number.separatePhoneAndPhoneCode().phone,
        name: e.displayName,
        email: e.emails.firstOrNull?.address,
        numberType: e.phones.firstOrNull?.label,
        //TODO: update other peoperties from server data
        isSpam: serverData?.isSpam,
        isBlocked: serverData?.isBlocked,
        isOnline: serverData?.isOnline,
        isRegistered: serverData?.isRegistered,
        lastSeen: serverData?.lastSeen,
        category: serverData?.category,
        markspambyuser: serverData?.markspambyuser,
        usuallyCalls: serverData?.usuallyCalls,
        callActivity: serverData?.callActivity,
        callHistory: serverData?.callHistory,
        spamReport: serverData?.spamReport,
        synced: serverData?.synced ?? false,
        isMarkedSpamByMe: serverData?.isMarkedSpamByMe ?? false,
        spamComments: serverData?.spamComments,
      );

  Contact toContact() => Contact(
      id: deviceContactId ?? "",
      phones: [Phone(number: mobileNo ?? "", label: numberType ?? "")],
      emails: [Email(address: email ?? "", label: "")],
      organization:
          Organization(company: "", department: "", jobDescription: ""),
      structuredName: StructuredName(
          displayName: name ?? "",
          namePrefix: "",
          givenName: "",
          middleName: "",
          familyName: "",
          nameSuffix: ""));
}

class SpamComment {
  final String? id;
  final String? comments;
  final String? numberType;
  final String? spamNo;
  final String? categoryName;
  final String? categoryId;
  final String? reportsByUser;
  final String? name;
  final String? reportByUsername;

  SpamComment({
    this.id,
    this.comments,
    this.numberType,
    this.spamNo,
    this.categoryName,
    this.categoryId,
    this.reportsByUser,
    this.name,
    this.reportByUsername,
  });

  SpamComment copyWith({
    String? id,
    String? comments,
    String? numberType,
    String? spamNo,
    String? categoryName,
    String? categoryId,
    String? reportsByUser,
    String? name,
    String? reportByUsername,
  }) =>
      SpamComment(
        id: id ?? this.id,
        comments: comments ?? this.comments,
        numberType: numberType ?? this.numberType,
        spamNo: spamNo ?? this.spamNo,
        categoryName: categoryName ?? this.categoryName,
        categoryId: categoryId ?? this.categoryId,
        reportsByUser: reportsByUser ?? this.reportsByUser,
        name: name ?? this.name,
        reportByUsername: reportByUsername ?? this.reportByUsername,
      );

  factory SpamComment.fromJson(Map<String, dynamic> json) => SpamComment(
        id: json["id"],
        comments: json["comments"],
        numberType: json["number_type"],
        spamNo: json["spam_no"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        reportsByUser: json["reports_by_user"],
        name: json["name"],
        reportByUsername: json["report_by_username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comments": comments,
        "number_type": numberType,
        "spam_no": spamNo,
        "category_name": categoryName,
        "category_id": categoryId,
        "reports_by_user": reportsByUser,
        "name": name,
        "report_by_username": reportByUsername,
      };
}
