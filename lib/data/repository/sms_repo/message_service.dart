import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

class MessageSyncService {
  static Future<void> syncMessages() async {
    final db = SmsLogDBHandler.instance;

    try {
      // Step 1: Get unsynced logs
      final unsyncedMessagesDetails =
          await db.getUnsyncedMessages(limit: 100, start: 0);
      log("First message date : ${unsyncedMessagesDetails.firstOrNull?.date.toString()}");
      log("Last message date : ${unsyncedMessagesDetails.lastOrNull?.date.toString()}");

      if (unsyncedMessagesDetails.isEmpty) {
        SharedPref.setLastSyncDate(DateTime.now());
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
          threadId: int.tryParse(e.threadId ?? '0') ?? 0,
        );
      }).toList();

      // Step 4: Send to server
      final resp = await syncSmsWithServer(smsLogs: smsMessages);
      final serverSmsLogs = (await smsList()).smsLog ?? [];

      // if (resp.statusCode == 200) {
      //   //set last sync date
      //   // SharedPref.setLastSyncDate(DateTime.now());
      //   // Step 5: Mark each SmsLog (not SmsDetail) as synced
      //   for (var log in serverSmsLogs) {
      //     final exists = await db.getSmsLog(log.address ?? "");
      //     if (exists != null) {
      //       await db.updateSmsLog(
      //           log.copyWith(date: getLatestDate(log, exists), synced: true));
      //     } else {
      //       //Don't insert new messages
      //       // await db.insertSmsLog(log.copyWith(synced: true));
      //     }
      //   }
      //   print("✅ Synced ${smsMessages.length} messages successfully.");
      // } else {

      if (resp.statusCode == 200) {
        // SharedPref.setLastSyncDate(DateTime.now());

        // Build a map for quick lookup using composite keys
        final serverLogMap = {
          // for (var log in serverSmsLogs) '${log.address}_${log.threadId}': log,
          for (var log in serverSmsLogs) '${log.address}': log,
        };

        for (var local in unsyncedMessagesDetails) {
          // final key = '${local.address}_${local.threadId}';
          final key = '${local.address}';
          final serverLog = serverLogMap[key];

          if (serverLog != null) {
            final existing = await db.getSmsLog(local.address ?? "");
            if (existing != null) {
              await db.updateSmsLog(
                local.copyWith(
                  name: (existing.name?.isEmpty ?? true)
                      ? serverLog.name
                      : existing.name,
                  synced: true,
                  isMarkSpam: serverLog.isMarkSpam,
                  isSpam: serverLog.isSpam,
                  totalMarkSpamCountByUser: serverLog.totalMarkSpamCountByUser,
                  unreadReceivedSms: serverLog.unreadReceivedSms,
                  date: getLatestDate(serverLog, existing),
                ),
              );
            } else {
              print("✅ Existing message not found, skipping.");
            }
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
    switch (kind?.toLowerCase()) {
      case 'sent':
        return SmsMessageKind.Sent;
      case 'received':
        return SmsMessageKind.Received;
      case 'draft':
        return SmsMessageKind.Draft;
      default:
        return SmsMessageKind.Draft;
    }
  }
}
