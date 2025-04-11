import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

Future<List<Contact>?> getLocalContacts() async {
  List<Contact> contacts = [];
  var status = await Permission.contacts.status;

  // await permissionRequest(Permission.contacts).then((status) async {
  if (status == PermissionStatus.granted) {
    contacts = await FastContacts.getAllContacts();
    return contacts;
    // syncContacts(contacts);
  } else {
    log("Phone Permission status: ${status?.name}");
    // return contacts;
    throw PermissionException("Contact permission status : ${status.name}");
  }
  // });
  // return contacts;
}
