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
    on<SyncMessagesWithServer>(_syncMessagesWithServer);
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
      DeleteAllSmsLogs event, Emitter<MessageDBState> emit) async {
    await _handleDbWrite(() async {
      for (final sms in event.smsLog.smsDetails ?? []) {
        await SMSController.deleteDeviceSms(sms);
      }
      await deleteConversation(address: event.smsLog.address ?? "");
      await _db.deleteSmsLog(event.smsLog.id ?? "");
    }, emit, onSuccess: () => MessageDBDeletedAllConversation());
  }

  Future<void> _deleteSmsLog(
      DeleteSmsLog event, Emitter<MessageDBState> emit) async {
    await _handleDbWrite(() async {
      await smsDelete(messageId: event.id);
      await _db.deleteSmsLog(event.id);
    }, emit, onSuccess: () => const MessageDBLoaded([]));
  }

  Future<void> _deleteDatabase(
      DeleteMessageDB event, Emitter<MessageDBState> emit) async {
    await _handleDbWrite(() async => await _db.deleteDatabase1(), emit,
        onSuccess: () => MessageDBInitial());
  }

  Future<void> _syncMessagesWithServer(
      SyncMessagesWithServer event, Emitter<MessageDBState> emit) async {
    emit(MessageDBSyncing());
    try {
      final localSms = await SMSController.getDeviceSms();
      final grouped = _groupSmsByAddress(localSms);

      await syncSmsWithServer(
          smsLogs: grouped.values.map((s) => s.first).toList());

      final serverLogs = (await smsList()).smsLog ?? [];
      final mergedLogs =
          await _mergeLocalAndServerMessages(grouped, serverLogs);

      for (final log in mergedLogs) {
        final exists = await _db.getSmsLog(log.id ?? "");
        if (exists == null) {
          await _db.insertSmsLog(log);
        } else {
          await _db.updateSmsLog(log);
        }
      }

      emit(MessageDBLoaded(await _db.getAllSmsLogs()));
    } catch (e) {
      emit(MessageDBError('Failed to sync messages: $e', e));
    }
  }

  Future<void> _syncMessageDetailsWithServer(
      SyncMessageDetailsWithServer event, Emitter<MessageDBState> emit) async {
    final address = event.smsLogs.address;
    final localMsgs = await SMSController.getDeviceSms(address: address);
    final serverDetails = (await syncSmsDetailsWithServer(
                smsLogs: localMsgs, address: address ?? ""))
            .smsLogDetails ??
        [];
    final updatedLog = await _mergeMessageDetails(localMsgs, serverDetails);

    final exists = await _db.getSmsLog(updatedLog.id ?? "");
    exists == null
        ? await _db.insertSmsLog(updatedLog)
        : await _db.updateSmsLog(updatedLog);

    emit(MessageDBLoaded(await _db.getAllSmsLogs()));
  }

  Future<void> _syncChangedMessagesWithServer(
      SyncChangedMessageWithServer event, Emitter<MessageDBState> emit) async {
    emit(MessageDBSyncing());
    try {
      await syncSmsWithServer(smsLogs: [event.smsMessage]);

      final contact = await _contacts.getContactByPhone(
          event.smsMessage.address?.separatePhoneAndPhoneCode().phone ?? "");
      final log = SmsLog.fromSmsMessage(event.smsMessage, contact, null)
          .copyWith(smsDetails: [
        SmsDetail.fromSmsMessage(event.smsMessage, SmsDetail(), contact)
      ]);

      final exists = await _db.getSmsLog(log.id ?? "");
      exists == null
          ? await _db.insertSmsLog(log)
          : await _db.updateSmsLog(log);

      emit(MessageDBLoaded(await _db.getAllSmsLogs()));
    } catch (e) {
      emit(MessageDBError('Failed to sync changed message: $e', e));
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
    final logs = await _db.getAllSmsLogs(); // <- Await first
    await _handleDbWrite(() async {
      log("Get all sms");
    }, emit, onSuccess: () => MessageDBLoaded(logs)); // <- Sync function
  }

  Future<void> _readDBSms(
      ReadDBMessage event, Emitter<MessageDBState> emit) async {
    await smsSeen(sms: event.sms);
    final exists = await _db.getSmsLog(event.sms.id ?? "");
    exists == null
        ? await _db.insertSmsLog(event.sms)
        : await _db.updateSmsLog(event.sms);
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
      emit(onSuccess?.call() ?? MessageDBLoaded(await _db.getAllSmsLogs()));
    } catch (e) {
      emit(MessageDBError('DB operation failed: $e', e));
    }
  }
}
