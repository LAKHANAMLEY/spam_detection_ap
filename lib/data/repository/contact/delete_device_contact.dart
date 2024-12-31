import 'package:flutter_contacts/flutter_contacts.dart';

Future<Contact> deleteDeviceContact({required String id}) async {
  Contact contact = Contact(id: id);
  return await contact.insert();
}
