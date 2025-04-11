import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:spam_delection_app/data/repository/contact/add_device_contact.dart';

Future<Contact> editDeviceContact(
    {required String name,
    required String email,
    required String phone,
    required String numberType,
    required String contactId}) async {
  Contact contact = Contact(
    name: Name(first: name),
    emails: [Email(email)],
    phones: [Phone(phone, label: getPhoneLabel(numberType))],
  );
  return await contact.insert();
}
