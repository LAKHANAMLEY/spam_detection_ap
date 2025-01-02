import 'package:flutter_contacts/flutter_contacts.dart';

Future<void> deleteDeviceContact({
  required String id,
  required String number,
}) async {
  Contact contact = Contact(id: id, phones: [Phone(number)]);
  // FlutterContacts.deleteContact(contact);
  return await contact.delete();
}
// ok sir
