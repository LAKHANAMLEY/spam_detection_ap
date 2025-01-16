import 'package:call_e_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/utils/permission_request.dart';

Future<List<CallLogEntry>> getDeviceCallLogs({
  String? number,
  DateTime? dateTimeFrom,
  DateTime? dateTimeTo,
}) async {
  permissionRequest(Permission.contacts);
  permissionRequest(Permission.phone);
// GET WHOLE CALL LOG
  // Iterable<CallLogEntry> entries = await CallLog.get();
  Iterable<CallLogEntry> entries = await CallLog.query(
    number: number,
    dateTimeFrom: dateTimeFrom,
    dateTimeTo: dateTimeFrom,
  );
  return entries.toList();

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
