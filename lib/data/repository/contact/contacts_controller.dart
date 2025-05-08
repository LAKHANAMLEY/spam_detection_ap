import 'dart:developer';

import 'package:fast_contacts/fast_contacts.dart' as f;
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/utils/api_constants/exception_handling.dart';
// import 'package:spam_delection_app/lib.dart' hide Contact;

class ContactsController {
  static Future<List<f.Contact>?> getLocalContacts() async {
    List<f.Contact> contacts = [];
    var status = await Permission.contacts.status;

    // await permissionRequest(Permission.contacts).then((status) async {
    if (status == PermissionStatus.granted) {
      contacts = await f.FastContacts.getAllContacts();
      return contacts;
      // syncContacts(contacts);
    } else {
      log("Phone Permission status: ${status.name}");
      // return contacts;
      throw PermissionException("Contact permission status : ${status.name}");
    }
    // });
    // return contacts;
  }

  static Future<fc.Contact> addDeviceContact({
    required String name,
    required String email,
    required String phone,
    required String numberType,
  }) async {
    try {
      fc.Contact contact = fc.Contact(
        name: fc.Name(first: name),
        emails: [fc.Email(email)],
        phones: [fc.Phone(phone, label: getPhoneLabel(numberType))],
      );
      return await contact.insert();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fc.PhoneLabel getPhoneLabel(String? phoneLabel) {
    fc.PhoneLabel label = fc.PhoneLabel.mobile;
    switch (phoneLabel) {
      case "assistant":
        label = fc.PhoneLabel.assistant;
      case "callback":
        label = fc.PhoneLabel.callback;

      case "car":
        label = fc.PhoneLabel.car;

      case "companyMain":
        label = fc.PhoneLabel.companyMain;

      case "faxHome":
        label = fc.PhoneLabel.faxHome;

      case "faxOther":
        label = fc.PhoneLabel.faxOther;

      case "faxWork":
        label = fc.PhoneLabel.faxWork;

      case "home":
        label = fc.PhoneLabel.home;

      case "iPhone":
        label = fc.PhoneLabel.iPhone;

      case "isdn":
        label = fc.PhoneLabel.isdn;

      case "main":
        label = fc.PhoneLabel.main;

      case "mms":
        label = fc.PhoneLabel.mms;

      case "mobile":
        label = fc.PhoneLabel.mobile;

      case "pager":
        label = fc.PhoneLabel.pager;

      case "radio":
        label = fc.PhoneLabel.radio;

      case "school":
        label = fc.PhoneLabel.school;

      case "telex":
        label = fc.PhoneLabel.telex;

      case "ttyTtd":
        label = fc.PhoneLabel.ttyTtd;

      case "work":
        label = fc.PhoneLabel.work;

      case "workMobile":
        label = fc.PhoneLabel.workMobile;

      case "workPager":
        label = fc.PhoneLabel.workPager;

      case "other":
        label = fc.PhoneLabel.other;

      case "custom":
        label = fc.PhoneLabel.custom;
    }
    return label;
  }

  static Future<void> deleteDeviceContact({
    required String id,
    required String number,
  }) async {
    fc.Contact contact = fc.Contact(id: id, phones: [fc.Phone(number)]);
    // FlutterContacts.deleteContact(contact);
    return await contact.delete();
  }

  static Future<fc.Contact> editDeviceContact(
      {required String name,
      required String email,
      required String phone,
      required String numberType,
      required String contactId}) async {
    fc.Contact contact = fc.Contact(
      id: contactId,
      name: fc.Name(first: name),
      emails: [fc.Email(email)],
      phones: [fc.Phone(phone, label: getPhoneLabel(numberType))],
    );
    return await contact.update();
  }
}
