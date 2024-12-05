import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

Future<List<Contact>?> getLocalContacts() async {
  List<Contact> contacts = [];
  await permissionRequest(Permission.contacts).then((status) async {
    if (status == PermissionStatus.granted) {
      contacts = await FastContacts.getAllContacts();
      return contacts;
      // syncContacts(contacts);
    } else {
      print("$status");
      return contacts;
    }
  });
  return contacts;
}
