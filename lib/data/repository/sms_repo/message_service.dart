import 'package:spam_delection_app/lib.dart';

class MessageSyncService {
  static Future<void> syncMessages() async {
    final db = SmsLogDBHandler.instance;

    try {
      // Step 1: Get unsynced logs
      final unsyncedMessagesDetails =
          await db.getUnsyncedMessages(limit: 10000, start: 0);

      if (unsyncedMessagesDetails.isEmpty) {
        print("✅ No unsynced messages to sync.");
        return;
      }

      // Step 2: Flatten all SmsDetails
      // final unsyncedMessagesDetails = unsyncedMessages
      //     .expand((smsLog) => smsLog.smsDetails ?? <SmsDetail>[])
      //     .toList();

      // grouped.values.map((s) => s.first).toList();

      if (unsyncedMessagesDetails.isEmpty) {
        print("⚠️ Unsynced logs found, but no SmsDetails to sync.");
        return;
      }

      // Step 3: Convert to SmsMessage format
      final smsMessages = unsyncedMessagesDetails.map((e) {
        return SmsMessage(
          e.address,
          e.body,
          id: int.tryParse(e.id ?? '0') ?? 0,
          date: e.date,
          dateSent: e.date,
          kind: _mapKind(e.smsDetails?.firstOrNull?.messageKind),
          read: (e.unreadReceivedSms ?? 0) > 0,
          threadId:
              int.tryParse(e.smsDetails?.firstOrNull?.threadId ?? '0') ?? 0,
        );
      }).toList();

      // Step 4: Send to server
      final resp = await syncSmsWithServer(smsLogs: smsMessages);
      final serverSmsLogs = (await smsList()).smsLog ?? [];

      if (resp.statusCode == 200) {
        //set last sync date
        SharedPref.setLastSyncDate(DateTime.now());
        // Step 5: Mark each SmsLog (not SmsDetail) as synced
        for (var log in serverSmsLogs) {
          final exists = await db.getSmsLog(log.address ?? "");
          if (exists != null) {
            await db.updateSmsLog(
                log.copyWith(date: getLatestDate(log, exists), synced: true));
          } else {
            //Don't insert new messages
            // await db.insertSmsLog(log.copyWith(synced: true));
          }
        }
        print("✅ Synced ${smsMessages.length} messages successfully.");
      } else {
        throw Exception("❌ Server responded with status ${resp.statusCode}");
      }
    } catch (e, stack) {
      print("❌ Error during message sync: $e\n$stack");
      // Optional: report to FirebaseCrashlytics or log to DB
      rethrow; // Let WorkManager know to retry later
    }
  }

  static SmsMessageKind _mapKind(String? kind) {
    switch (kind) {
      case 'Sent':
        return SmsMessageKind.Sent;
      case 'Received':
        return SmsMessageKind.Received;
      case 'Draft':
        return SmsMessageKind.Draft;
      default:
        return SmsMessageKind.Draft;
    }
  }
}
