import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/utils/permission_request.dart';

Future<List<Contact>?> getLocalContacts() async {
  await permissionRequest(Permission.contacts).then((status) async {
    if (status == PermissionStatus.granted) {
      final contacts = await FastContacts.getAllContacts();
      return contacts;
      // syncContacts(contacts);
    } else {
      print("$status");
      return null;
    }
  });
  return null;
}
