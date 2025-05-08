import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

class ContactSyncService {
  static Future<void> syncContacts() async {
    final db = ContactDBHelper.instance;

    try {
      // Step 1: Get unsynced contacts
      final unsyncedContacts =
          await db.getUnsyncedContacts(limit: 100, start: 0);

      if (unsyncedContacts.isEmpty) {
        log("✅ No unsynced contacts to sync.");
        return;
      }

      // Step 2: Convert to server expected model
      final contactMessages =
          unsyncedContacts.map((e) => e.toContact()).toList();

      // Step 3: Send to server
      final resp = await syncContactsWithServer(contactMessages);
      final serverContacts = (await getContacts()).contactslist ?? [];
      // final serverContacts = resp.contactslist ?? [];

      if (resp.statusCode == 200) {
        SharedPref.setLastContactSyncDate(DateTime.now());

        // Step 4: Map server contacts for fast lookup
        final serverMap = {
          for (var contact in serverContacts) contact.mobileNo: contact,
        };

        for (var local in unsyncedContacts) {
          final matched = serverMap[local.mobileNo];
          if (matched != null) {
            await db.update(local.copyWith(
              synced: true,
              isSpam: matched.isSpam,
              markspambyuser: matched.markspambyuser,
              isBlocked: matched.isBlocked,
              callActivity: matched.callActivity,
              callHistory: matched.callHistory,
              category: matched.category,
              isOnline: matched.isOnline,
              isRegistered: matched.isRegistered,
              lastSeen: matched.lastSeen,
              spamReport: matched.spamReport,
              usuallyCalls: matched.usuallyCalls,
              name: (local.name?.isEmpty ?? true) ? matched.name : local.name,
            ));
          } else {
            // Mark synced anyway if not found, or skip based on logic
            // await db.update(local.copyWith(synced: true));
            print("✅ Existing contact not found, skipping.");
          }
        }

        log("✅ Synced ${unsyncedContacts.length} contacts successfully.");
      } else {
        throw Exception("❌ Server responded with status ${resp.statusCode}");
      }
    } catch (e, stack) {
      log("❌ Error during contact sync: $e\n$stack");
      rethrow;
    }
  }
}
