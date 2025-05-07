import 'package:spam_delection_app/lib.dart';

extension CallLogDataExt on CallLogEntry {
  CallLogEntry fromCallLogData(CallLogData e) => CallLogEntry(
        number: e.mobileNo,
        name: e.name,
        callType: getCallLogType(e.callType),
        duration: int.tryParse(e.callDuration ?? ""),
        timestamp: e.callTime?.millisecondsSinceEpoch,
        simDisplayName: e.simdisplayname,
        phoneAccountId: e.phoneaccountid,
        formattedNumber: e.mobileNo,
      );
}
