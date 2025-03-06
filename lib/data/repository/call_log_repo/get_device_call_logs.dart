import 'dart:developer';

import 'package:call_e_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/utils/functions/permission_request.dart';

Future<List<CallLogEntry>> getDeviceCallLogs({
  String? number,
  DateTime? dateTimeFrom,
  DateTime? dateTimeTo,
}) async {
  var contactPermissionStatus = await permissionRequest(Permission.contacts);
  var phonePermissionStatus = await permissionRequest(Permission.phone);
// GET WHOLE CALL LOG
  // Iterable<CallLogEntry> entries = await CallLog.get();
  if ((contactPermissionStatus?.isGranted ?? false) &&
      (phonePermissionStatus?.isGranted ?? false)) {
    Iterable<CallLogEntry> entries = await CallLog.query(
      number: number,
      dateTimeFrom: dateTimeFrom,
      dateTimeTo: dateTimeFrom,
    );
    return entries.toList();
  } else {
    log("Contact Permission status: ${contactPermissionStatus?.name}");
    log("Phone Permission status: ${phonePermissionStatus?.name}");
    return [];
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
