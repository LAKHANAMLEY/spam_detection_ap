import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

Future<List<CallLogEntry>> getDeviceCallLogs({
  String? number,
  DateTime? dateTimeFrom,
  DateTime? dateTimeTo,
}) async {
  var phonePermissionStatus = await Permission.phone.status;
  // var phonePermissionStatus = await permissionRequest(Permission.phone);
// GET WHOLE CALL LOG
  // Iterable<CallLogEntry> entries = await CallLog.get();
  if ((phonePermissionStatus.isGranted ?? false)) {
    Iterable<CallLogEntry> entries = await CallLog.query(
      number: number,
      dateTimeFrom: dateTimeFrom,
      dateTimeTo: dateTimeFrom,
    );
    return entries.toList();
  } else {
    // log("Contact Permission status: ${contactPermissionStatus?.name}");
    log("Phone Permission status: ${phonePermissionStatus.name}");
    // return [];
    throw PermissionException(
        "Phone Permission status : ${phonePermissionStatus.name}");
  }

// QUERY CALL LOG (ALL PARAMS ARE OPTIONAL)
  // var now = DateTime.now();
  // int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
  // int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;
  // Iterable<CallLogEntry> entries = await CallLog.query(
  //   dateFrom: from,
  //   dateTo: to,
  //   durationFrom: 0,
  //   durationTo: 60,
  //   name: 'John Doe',
  //   number: '901700000',
  //   type: CallType.incoming,
  // );
}
