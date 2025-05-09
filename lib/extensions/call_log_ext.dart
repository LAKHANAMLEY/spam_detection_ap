import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/utils/call_type_helper/call_type_helpers.dart';

extension CallLogDataExt on CallLogEntry {
  CallLogEntry fromCallLogData(CallLogData e) => CallLogEntry(
        number: e.mobileNo,
        name: e.name,
        callType: CallTypeHelper.getCallLogType(e.callType),
        duration: int.tryParse(e.callDuration ?? ""),
        timestamp: e.callTime?.millisecondsSinceEpoch,
        simDisplayName: e.simdisplayname,
        phoneAccountId: e.phoneaccountid,
        formattedNumber: e.mobileNo,
      );
}
