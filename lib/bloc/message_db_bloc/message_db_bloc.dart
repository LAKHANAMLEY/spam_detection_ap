import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

class MessageDBBloc extends Bloc<MessageDBEvent, MessageDBState> {
  final SmsLogDBHandler _db = SmsLogDBHandler.instance;
  final ContactDBHelper _contacts = ContactDBHelper.instance;

  MessageDBBloc() : super(MessageDBInitial()) {
    on<AddSmsLog>(_addSmsLog);
    on<DeleteSmsLog>(_deleteSmsLog);
    on<DeleteAllSmsLogs>(_deleteAllSmsLogs);
    on<DeleteMessageDB>(_deleteDatabase);
    on<PaginateAndSyncMessagesWithServer>(_paginateAndsyncMessagesWithServer);
    on<SyncMessageDetailsWithServer>(_syncMessageDetailsWithServer);
    on<SyncChangedMessageWithServer>(_syncChangedMessagesWithServer);
    on<AddSmsLogsToDB>(_addSmsLogsToDB);
    on<GetAllSmsFromDB>(_getAllSmsFromDB);
    on<ReadDBMessage>(_readDBSms);
  }

  Future<void> _addSmsLog(AddSmsLog event, Emitter<MessageDBState> emit) async {
    await _handleDbWrite(() async {
      await _db.insertSmsLog(event.smsLog);
    }, emit);
  }

  Future<void> _deleteAllSmsLogs(
    DeleteAllSmsLogs event,
    Emitter<MessageDBState> emit,
  ) async {
    try {
      // Perform DB operations
      await _handleDbWrite(() async {
        for (final sms in event.smsLog.smsDetails ?? []) {
          await SMSController.deleteDeviceSms(sms);
        }
        await deleteConversation(address: event.smsLog.address ?? "");
        await _db.deleteSmsLog(event.smsLog.id ?? "");
      }, emit, onSuccess: () => MessageDBLoaded([]));
    } catch (e) {
      emit(MessageDBError('Failed to delete all logs: $e', e));
    }
  }

  Future<void> _deleteSmsLog(
      DeleteSmsLog event, Emitter<MessageDBState> emit) async {
    final smsLog = await _db.getSmsLog(event.id);
    await _handleDbWrite(() async {
      await smsDelete(messageId: event.id);
      await _db.deleteSmsLog(event.id);
    }, emit, onSuccess: () => MessageDBDeletedById(smsLog: smsLog!));
  }

  Future<void> _deleteDatabase(
      DeleteMessageDB event, Emitter<MessageDBState> emit) async {
    await _handleDbWrite(() async => await _db.deleteDatabase1(), emit,
        onSuccess: () => MessageDBInitial());
  }

  // Future<void> _paginateAndsyncMessagesWithServer(
  //   PaginateAndSyncMessagesWithServer event,
  //   Emitter<MessageDBState> emit,
  // ) async {
  //   try {
  //     emit(MessageDBLoading());

  //     final paginatedSms = await SMSController.getDeviceSms(
  //       count: event.limit,
  //       start: event.start,
  //     );

  //     if (paginatedSms.isEmpty) {
  //       emit(MessageDBSynced(await _db.getSmsLogsPaginated(
  //         limit: event.limit,
  //         start: event.start,
  //       )));
  //       return;
  //     }

  //     for (final sms in paginatedSms) {
  //       final log = SmsLog.fromSmsMessage(sms, ContactData(), null);
  //       final exists = await _db.getSmsLog(log.id ?? "");
  //       if (exists != null) {
  //         await _db.updateSmsLog(log);
  //       } else {
  //         await _db.insertSmsLog(log);
  //       }
  //     }

  //     final grouped = _groupSmsByAddress(paginatedSms);
  //     await syncSmsWithServer(
  //       smsLogs: grouped.values.map((s) => s.first).toList(),
  //     );

  //     final serverLogs = (await smsList()).smsLog ?? [];
  //     final mergedLogs =
  //         await _mergeLocalAndServerMessages(grouped, serverLogs);

  //     for (final log in mergedLogs) {
  //       final exists = await _db.getSmsLog(log.id ?? "");
  //       if (exists != null) {
  //         await _db.updateSmsLog(log);
  //       } else {
  //         await _db.insertSmsLog(log);
  //       }
  //     }

  //     emit(MessageDBSynced(await _db.getSmsLogsPaginated(
  //       start: event.start,
  //       limit: event.limit,
  //     )));
  //   } catch (e) {
  //     emit(MessageDBError('Pagination sync failed: $e', e));
  //   }
  // }
  Future<void> _paginateAndsyncMessagesWithServer(
    PaginateAndSyncMessagesWithServer event,
    Emitter<MessageDBState> emit,
  ) async {
    try {
      // Load messages from SQLite, no loading state here
      final paginatedSms = await SMSController.getDeviceSms(
        count: event.limit,
        start: event.start,
      );

      if (paginatedSms.isEmpty) {
        emit(MessageDBSynced(await _db.getSmsLogsPaginated(
          limit: event.limit,
          start: event.start,
        )));
        return;
      }

      for (final sms in paginatedSms) {
        final log = SmsLog.fromSmsMessage(sms, ContactData(), null);
        final exists = await _db.getSmsLog(log.id ?? "");
        if (exists != null) {
          await _db
              .updateSmsLog(log.copyWith(date: _getLatestDate(log, exists)));
        } else {
          await _db.insertSmsLog(log);
        }
      }

      final grouped = _groupSmsByAddress(paginatedSms);

      // Sync messages with the server in the background
      await syncSmsWithServer(
        smsLogs: grouped.values.map((s) => s.first).toList(),
      );

      final serverLogs = (await smsList()).smsLog ?? [];
      final mergedLogs =
          await _mergeLocalAndServerMessages(grouped, serverLogs);

      for (final log in mergedLogs) {
        final exists = await _db.getSmsLog(log.id ?? "");
        if (exists != null) {
          await _db
              .updateSmsLog(log.copyWith(date: _getLatestDate(log, exists)));
        } else {
          await _db.insertSmsLog(log);
        }
      }

      // After sync, fetch the updated logs from SQLite
      emit(MessageDBSynced(await _db.getSmsLogsPaginated(
        start: event.start,
        limit: event.limit,
      )));
    } catch (e) {
      // Don't emit a loading state if it fails
      emit(MessageDBError('Pagination sync failed: $e', e));
    }
  }

  Future<void> _syncMessageDetailsWithServer(
      SyncMessageDetailsWithServer event, Emitter<MessageDBState> emit) async {
    try {
      final address = event.smsLogs.address;
      final threadId = event.smsLogs.smsDetails?.firstOrNull?.threadId;
      if (threadId == null) return;

      final localMsgs =
          await SMSController.getDeviceSms(threadId: int.parse(threadId));
      if (localMsgs.isEmpty) return;

      final serverDetails = (await syncSmsDetailsWithServer(
                  smsLogs: localMsgs, address: address ?? ""))
              .smsLogDetails ??
          [];

      final updatedLog = await _mergeMessageDetails(localMsgs, serverDetails);

      final exists = await _db.getSmsLog(updatedLog.id ?? "");
      if (exists == null) {
        await _db.insertSmsLog(updatedLog);
      } else {
        await _db.updateSmsLog(
            updatedLog.copyWith(date: _getLatestDate(updatedLog, exists)));
      }

      emit(MessageDBSynced(await _db.getAllSmsLogs()));
    } catch (e) {
      emit(MessageDBError('Failed to sync message detail: $e', e));
    }
  }

  Future<void> _syncChangedMessagesWithServer(
      SyncChangedMessageWithServer event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      final newMessage = event.smsMessage;
      final address = newMessage.address;
      final threadId = newMessage.threadId;
      if (threadId == null) return;

      final lastLocalMessage = await SMSController.getLastSms(newMessage);
      final localMsgs = [lastLocalMessage];
      if (localMsgs.isEmpty) return;

      final serverDetails = (await syncSmsDetailsWithServer(
                  smsLogs: localMsgs, address: address ?? ""))
              .smsLogDetails ??
          [];

      final updatedLog = await _mergeMessageDetails(localMsgs, serverDetails);

      final exists = await _db.getSmsLog(updatedLog.id ?? "");
      if (exists == null) {
        await _db.insertSmsLog(updatedLog);
      } else {
        await _db.updateSmsLog(updatedLog.copyWith(
            name: exists.name, date: _getLatestDate(updatedLog, exists)));
      }

      emit(NewMessageReceived(await _db.getAllSmsLogs()));
    } catch (e) {
      emit(MessageDBError('Failed to sync received/sent message: $e', e));
    }
  }

  Future<void> _addSmsLogsToDB(
      AddSmsLogsToDB event, Emitter<MessageDBState> emit) async {
    await _handleDbWrite(() async {
      for (final log in event.smsLogs) {
        await _db.insertSmsLog(log);
      }
    }, emit);
  }

  Future<void> _getAllSmsFromDB(
      GetAllSmsFromDB event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      final logs =
          await _db.getSmsLogsPaginated(start: event.start, limit: event.limit);
      emit(MessageDBLoaded(logs));
    } catch (e) {
      emit(MessageDBError('Failed to load messages: $e', e));
    }
  }

  Future<void> _readDBSms(
      ReadDBMessage event, Emitter<MessageDBState> emit) async {
    await smsSeen(sms: event.sms);
    final exists = await _db.getSmsLog(event.sms.id ?? "");
    if (exists == null) {
      await _db.insertSmsLog(event.sms);
    } else {
      await _db.updateSmsLog(
          event.sms.copyWith(date: _getLatestDate(event.sms, exists)));
    }
    // emit(MessageDBUpdated(event.sms)); // <-- Emit update state
  }

  // === UTILITY METHODS ===

  Map<String, List<SmsMessage>> _groupSmsByAddress(List<SmsMessage> messages) {
    return {
      for (var sms in messages)
        if (sms.address != null)
          sms.address!: [...messages.where((m) => m.address == sms.address)]
    };
  }

  Future<List<SmsLog>> _mergeLocalAndServerMessages(
    Map<String, List<SmsMessage>> groupedLocal,
    List<SmsLog> serverLogs,
  ) async {
    final serverMap = {for (var log in serverLogs) log.address!: log};
    final result = <SmsLog>[];

    for (final address in groupedLocal.keys) {
      final local = groupedLocal[address]!;
      final serverLog = serverMap[address];
      final contact = await _contacts
          .getContactByPhone(address.separatePhoneAndPhoneCode().phone);

      final details = local
          .map((sms) => SmsDetail.fromSmsMessage(
              sms,
              serverLog?.smsDetails?.firstWhere(
                (d) => d.deviceMessageId == sms.id.toString(),
                orElse: () => SmsDetail(),
              ),
              contact))
          .toList();

      result.add(
        SmsLog.fromSmsMessage(
                local.first, contact, SmsDetail.fromSmsLog(serverLog))
            .copyWith(smsDetails: details),
      );
    }

    return result;
  }

  Future<SmsLog> _mergeMessageDetails(
      List<SmsMessage> local, List<SmsDetail> serverDetails) async {
    final contact = await _contacts.getContactByPhone(
        local.first.address?.separatePhoneAndPhoneCode().phone ?? "");
    final serverMap = {for (var d in serverDetails) d.deviceMessageId!: d};

    final details = local
        .map((sms) => SmsDetail.fromSmsMessage(
            sms, serverMap[sms.id.toString()] ?? SmsDetail(), contact))
        .toList();

    return SmsLog.fromSmsMessage(local.first, contact, serverDetails.first)
        .copyWith(smsDetails: details);
  }

  Future<void> _handleDbWrite(
      Future<void> Function() action, Emitter<MessageDBState> emit,
      {MessageDBState Function()? onSuccess}) async {
    emit(MessageDBLoading());
    try {
      await action();
      emit(onSuccess?.call() ?? MessageDBSynced(await _db.getAllSmsLogs()));
    } catch (e) {
      emit(MessageDBError('DB operation failed: $e', e));
    }
  }

  DateTime? _getLatestDate(SmsLog log, SmsLog exists) {
    if (log.date == null) return exists.date;
    if (exists.date == null) return log.date;
    return log.date!.isAfter(exists.date!) ? log.date : exists.date;
  }
}
