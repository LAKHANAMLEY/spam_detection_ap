import 'package:spam_delection_app/lib.dart';

class CallLogSyncService {
  static Future<void> syncCallLogs() async {
    final db = CallLogDBHelper.instance;

    try {
      // Step 1: Get unsynced call logs
      final unsyncedCallLogs =
          await db.getUnsyncedCallLogs(limit: 100, start: 0);

      if (unsyncedCallLogs.isEmpty) {
        print("✅ No unsynced call logs to sync.");
        return;
      }

      // Step 2: Map to the format your server expects (e.g., CallLogMessage)
      final callLogEntries = unsyncedCallLogs.map((e) {
        return e.toCallLogEntry();
      }).toList();

      // Step 3: Send to server
      final resp = await syncCallLog(callLogs: callLogEntries);
      final serverCallLogs = (await getCallLogs()).callloglist ?? [];

      if (resp.statusCode == 200) {
        SharedPref.setLastCallLogSyncDate(DateTime.now());

        // Map server logs by unique identifier for fast lookup
        final serverLogMap = {
          for (var log in serverCallLogs)
            // '${log.mobileNo}_${log.callDuration}_${log.callType}': log
            '${log.mobileNo}': log
        };

        for (var sentLog in unsyncedCallLogs) {
          final key = '${sentLog.mobileNo}';
          // final key =
          //     '${sentLog.mobileNo}_${sentLog.callDuration}_${sentLog.callType}';
          // final key =
          //     '${sentLog.mobileNo}_${sentLog.callTime?.millisecondsSinceEpoch}';
          final serverLog = serverLogMap[key];

          if (serverLog != null) {
            await db.updateCallLog(sentLog.copyWith(
              synced: true,
              isSpam: serverLog.isSpam,
              markspambyuser: serverLog.markSpamByUser,
              contactListId: serverLog.contactListId,
              isBlocked: serverLog.isBlocked,
              name: (sentLog.name?.isEmpty ?? true)
                  ? serverLog.name
                  : sentLog.name,
              contactData: serverLog.contactData,
            ));
          } else {
            print(
                "⚠️ Server log not found for: ${sentLog.mobileNo} at ${sentLog.callTime}");
            // If server doesn't send info for this log, just mark it synced
            // await db.updateCallLog(sentLog.copyWith(synced: true));
          }
        }

        // SharedPref.setLastCallLogSyncDate(DateTime.now());

        // // Step 4: Mark each CallLog as synced
        // for (var log in serverCallLogs) {
        //   final existing = await db.getCallLog(log.mobileNo ?? "");
        //   if (existing != null) {
        //     await db.updateCallLog(existing.copyWith(
        //       synced: true,
        //       name: existing.name?.isEmpty ?? false ? log.name : existing.name,
        //       isSpam: log.isSpam,
        //       markspambyuser: log.markSpamByUser,
        //       contactListId: log.contactListId,
        //       // id: log.id,
        //       isBlocked: log.isBlocked,
        //     ));
        //   }
        // }

        print("✅ Synced ${callLogEntries.length} call logs successfully.");
      } else {
        throw Exception("❌ Server responded with status ${resp.statusCode}");
      }
    } catch (e, stack) {
      print("❌ Error during call log sync: $e\n$stack");
      rethrow;
    }
  }
}
