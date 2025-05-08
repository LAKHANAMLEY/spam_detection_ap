// import 'dart:developer';

// import 'package:flutter_contacts/flutter_contacts.dart';

// Future<Contact> addDeviceContact({
//   required String name,
//   required String email,
//   required String phone,
//   required String numberType,
// }) async {
//   try {
//     Contact contact = Contact(
//       name: Name(first: name),
//       emails: [Email(email)],
//       phones: [Phone(phone, label: getPhoneLabel(numberType))],
//     );
//     return await contact.insert();
//   } catch (e) {
//     log(e.toString());
//     throw Exception(e);
//   }
// }

// PhoneLabel getPhoneLabel(String? phoneLabel) {
//   PhoneLabel label = PhoneLabel.mobile;
//   switch (phoneLabel) {
//     case "assistant":
//       label = PhoneLabel.assistant;
//     case "callback":
//       label = PhoneLabel.callback;

//     case "car":
//       label = PhoneLabel.car;

//     case "companyMain":
//       label = PhoneLabel.companyMain;

//     case "faxHome":
//       label = PhoneLabel.faxHome;

//     case "faxOther":
//       label = PhoneLabel.faxOther;

//     case "faxWork":
//       label = PhoneLabel.faxWork;

//     case "home":
//       label = PhoneLabel.home;

//     case "iPhone":
//       label = PhoneLabel.iPhone;

//     case "isdn":
//       label = PhoneLabel.isdn;

//     case "main":
//       label = PhoneLabel.main;

//     case "mms":
//       label = PhoneLabel.mms;

//     case "mobile":
//       label = PhoneLabel.mobile;

//     case "pager":
//       label = PhoneLabel.pager;

//     case "radio":
//       label = PhoneLabel.radio;

//     case "school":
//       label = PhoneLabel.school;

//     case "telex":
//       label = PhoneLabel.telex;

//     case "ttyTtd":
//       label = PhoneLabel.ttyTtd;

//     case "work":
//       label = PhoneLabel.work;

//     case "workMobile":
//       label = PhoneLabel.workMobile;

//     case "workPager":
//       label = PhoneLabel.workPager;

//     case "other":
//       label = PhoneLabel.other;

//     case "custom":
//       label = PhoneLabel.custom;
//   }
//   return label;
// }
