// BLoC
import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

class MessageDBBloc extends Bloc<MessageDBEvent, MessageDBState> {
  final SmsLogDBHandler _databaseHelper = SmsLogDBHandler.instance;
  final ContactDBHelper _contactDBHelper = ContactDBHelper.instance;

  MessageDBBloc() : super(MessageDBInitial()) {
    // on<LoadSmsLogs>(_onLoadSmsLogs);
    on<AddSmsLog>(_onAddSmsLog);
    on<DeleteSmsLog>(_onDeleteSmsLog);
    on<DeleteAllSmsLogs>(_onDeleteAllSmsLogs);
    on<DeleteMessageDB>(_onDeleteDatabase);
    // on<LoadDeviceSms>(_onLoadDeviceSms);
    on<SyncMessagesWithServer>(_onSyncMessagesWithServer);
    on<SyncChangedMessageWithServer>(_onSyncChangedMessagesWithServer);
    on<AddSmsLogsToDB>(_onAddSmsLogsToDB);
    on<GetAllSmsFromDB>(_onGetAllSmsFromDB);
    on<ReadDBMessage>(_onReadDBSms);
  }

  // Future<void> _onLoadSmsLogs(
  //     LoadSmsLogs event, Emitter<MessageDBState> emit) async {
  //   emit(MessageDBLoading());
  //   try {
  //     final smsLogs = await _databaseHelper.getAllSmsLogs();
  //     emit(MessageDBLoaded(smsLogs));
  //   } catch (e) {
  //     emit(MessageDBError('Failed to load SMS logs from DB: $e'));
  //   }
  // }

  Future<void> _onAddSmsLog(
      AddSmsLog event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      await _databaseHelper.insertSmsLog(event.smsLog);
      final smsLogs = await _databaseHelper.getAllSmsLogs();
      emit(MessageDBLoaded(smsLogs));
    } catch (e) {
      emit(MessageDBError('Failed to add SMS log to DB: $e', e));
    }
  }

  Future<void> _onDeleteAllSmsLogs(
      DeleteAllSmsLogs event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      smsDelete(messageId: "");
      await _databaseHelper.deleteTable();
      final smsLogs = await _databaseHelper.getAllSmsLogs();
      emit(MessageDBLoaded(smsLogs));
    } catch (e) {
      emit(MessageDBError('Failed to delete all SMS logs from DB: $e', e));
    }
  }

  Future<void> _onDeleteSmsLog(
      DeleteSmsLog event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      ///TODO: delete sms from server and device
      await smsDelete(messageId: event.id);
      await _databaseHelper.delete(event.id);
      emit(const MessageDBLoaded([]));
    } catch (e) {
      emit(MessageDBError('Failed to delete all SMS logs from DB: $e', e));
    }
  }

  Future<void> _onDeleteDatabase(
      DeleteMessageDB event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      await _databaseHelper.deleteDatabase1();
      emit(MessageDBInitial());
    } catch (e) {
      emit(MessageDBError('Failed to delete the database: $e', e));
    }
  }

  // Future<void> _onLoadDeviceSms(
  //     LoadDeviceSms event, Emitter<MessageDBState> emit) async {
  //   emit(MessageDBLoading());
  //   try {
  //     final deviceSms = await getSms();
  //     emit(MessageDBLoaded(deviceSms)); // Emit the device SMS list
  //   } catch (e) {
  //     emit(MessageDBError('Failed to load SMS from device: $e'));
  //   }
  // }

  Map<String, List<SmsMessage>> getGroupedLocalSms(List<SmsMessage> localSms) {
    Map<String, List<SmsMessage>> groupedLocalSms = {};
    for (var sms in localSms) {
      final address = sms.address;
      if (address != null) {
        groupedLocalSms.putIfAbsent(address, () => []).add(sms);
      }
    }
    return groupedLocalSms;
  }

  Future<List<SmsLog>> syncLocalAndServerMessagesOneLoopLocalPriority(
      Map<String, List<SmsMessage>> groupedLocalSms,
      List<SmsLog> serverMessages) async {
    // Map<String, List<SmsMessage>> groupedLocalSms =
    //     getGroupedLocalSms(localSms);

    Map<String, SmsLog> serverMessagesMap = {
      for (var msg in serverMessages) msg.address!: msg
    };

    List<SmsLog> syncedSmsLogs = [];

    for (final address in groupedLocalSms.keys) {
      final localSmsList = groupedLocalSms[address]!;
      final serverLog = serverMessagesMap[address];

      //TODO: getDetailsFromContactDB name etc
      var contact = await _contactDBHelper.getContactByPhone(address);
      log(contact?.name ?? "");

      List<SmsDetail> smsDetails = [];

      // Add local SMS details
      smsDetails.addAll(localSmsList.map((sms) => SmsDetail(
            id: sms.id?.toString() ?? serverLog?.id,
            deviceMessageId: sms.id?.toString(),
            address: serverLog?.address ?? sms.address,
            countryCode: serverLog?.countryCode ??
                sms.address?.separatePhoneAndPhoneCode().phoneCode,
            body: sms.body,
            date: sms.date,
            messageKind: sms.kind?.name,
            messageState: sms.state.name,
            name: contact?.name ?? serverLog?.name ?? sms.sender,
            threadId: sms.threadId?.toString(),
            sendreceiveDatetime: sms.dateSent,
            isSpam: serverLog?.isMarkSpam.toString(),
            isRead: serverLog?.smsDetails?.firstOrNull?.isRead,
            queryKind: serverLog?.smsDetails?.firstOrNull?.queryKind,
            score: serverLog?.smsDetails?.firstOrNull?.score,
            spamMessage: serverLog?.smsDetails?.firstOrNull?.spamMessage,
          )));

      // Add server SMS details if available (and if a local message with this address exists)
      // if (serverLog?.smsDetails != null) {
      //   smsDetails.addAll(serverLog!.smsDetails!);
      // }

      syncedSmsLogs.add(
        SmsLog(
          id: address,
          address: serverLog?.address ?? address,
          countryCode: serverLog?.countryCode,
          unreadReceivedSms: serverLog?.unreadReceivedSms,
          name: contact?.name ??
              serverLog?.name ??
              localSmsList.firstOrNull?.sender,
          isMarkSpam: serverLog?.isMarkSpam,
          smsDetails: smsDetails,
        ),
      );

      // Optionally remove from the server map to avoid processing later
      serverMessagesMap.remove(address);
    }

    // We no longer add any remaining server messages here.

    return syncedSmsLogs;
  }

  Future<void> _onSyncMessagesWithServer(
      SyncMessagesWithServer event, Emitter<MessageDBState> emit) async {
    emit(MessageDBSyncing());
    try {
      ///1. Get device messages
      final localSmsLogs = await getDeviceSms();

      ///TODO: add name from local db contacts
      ///TODO: extend a copywith method for SMSMessage
      Map<String, List<SmsMessage>> groupedLocalSms =
          getGroupedLocalSms(localSmsLogs);

      // emit(MessageDBLoaded(groupedLocalSms.keys.map((key) {
      //   List<SmsMessage> log = groupedLocalSms[key] ?? [];
      //   var smsDetail = log
      //       .map((e) => SmsDetail(
      //             address: e.address?.separatePhoneAndPhoneCode().phone,
      //             countryCode: e.address?.separatePhoneAndPhoneCode().phoneCode,
      //             body: e.body,
      //             id: e.address,
      //             deviceMessageId: e.id.toString(),
      //             date: e.date,
      //             messageKind: e.kind?.name,
      //             messageState: e.state.name,
      //             name: e.sender,
      //             threadId: e.threadId?.toString(),
      //             sendreceiveDatetime: e.dateSent,
      //           ))
      //       .toList();
      //   return SmsLog(
      //       id: log.first.address,
      //       address: log.first.address,
      //       name: log.first.sender,
      //       smsDetails: smsDetail);
      // }).toList()));

      ///2. Sync with server
      await syncSmsWithServer(smsLogs: localSmsLogs);

      ///3. Get server messages
      final resp = await smsList();
      final serverMessages = resp.smsLog ?? [];

      ///4. Merge local and server messages
      final syncedSmsLogs =
          await syncLocalAndServerMessagesOneLoopLocalPriority(
              groupedLocalSms, serverMessages);
      // log("synced sms : ${syncedSmsLogs.map((e) => e.toJson()).toList()}");

      for (final smsLog in syncedSmsLogs) {
        final existingCallLog =
            await _databaseHelper.getSmsLog(smsLog.id ?? "");
        if (existingCallLog == null) {
          await _databaseHelper.insertSmsLog(smsLog);
        } else {
          await _databaseHelper.updateSmsLog(smsLog);
        }
      }
      final syncedSmsLogsFromDB = await _databaseHelper.getAllSmsLogs();
      // log(syncedSmsLogsFromDB.map((e) => e.toJson()).toList().toString());
      emit(MessageDBLoaded(syncedSmsLogsFromDB));
    } catch (e) {
      emit(MessageDBError('Failed to sync messages with server: $e', e));
    }
  }

  Future<void> _onSyncChangedMessagesWithServer(
      SyncChangedMessageWithServer event, Emitter<MessageDBState> emit) async {
    emit(MessageDBSyncing());
    try {
      await syncSmsWithServer(smsLogs: [event.smsMessage]);

      // final resp = await smsList();
      // final serverMessages = resp.smsLog ?? [];
      var sms = event.smsMessage;
      var smsLog = SmsLog(
          id: sms.address,
          address: sms.address,
          countryCode: sms.address?.separatePhoneAndPhoneCode().phoneCode,
          name: sms.sender,
          smsDetails: [
            SmsDetail(
              id: sms.address?.toString(),
              deviceMessageId: sms.address?.toString(),
              address: sms.address,
              countryCode: sms.address?.separatePhoneAndPhoneCode().phoneCode,
              body: sms.body,
              date: sms.date,
              messageKind: sms.kind?.name,
              messageState: sms.state.name,
              name: sms.sender,
              threadId: sms.threadId?.toString(),
              sendreceiveDatetime: sms.dateSent,
            )
          ]);

      // for (final smsLog in serverMessages) {
      final existingCallLog = await _databaseHelper.getSmsLog(smsLog.id ?? "");
      if (existingCallLog == null) {
        await _databaseHelper.insertSmsLog(smsLog);
      } else {
        var updatedLogId = await _databaseHelper.updateSmsLog(smsLog);
        log("$updatedLogId");
      }
      // }
      final syncedSmsLogs = await _databaseHelper.getAllSmsLogs();

      emit(MessageDBLoaded(syncedSmsLogs));
    } catch (e) {
      emit(MessageDBError('Failed to sync messages with server: $e', e));
    }
  }

  Future<void> _onAddSmsLogsToDB(
      AddSmsLogsToDB event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      for (final smsLog in event.smsLogs) {
        await _databaseHelper.insertSmsLog(smsLog);
      }
      final allSms = await _databaseHelper.getAllSmsLogs();
      emit(MessageDBLoaded(allSms));
    } catch (e) {
      emit(MessageDBError('Failed to add SMS logs to DB: $e', e));
    }
  }

  Future<void> _onGetAllSmsFromDB(
      GetAllSmsFromDB event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      final allSms = await _databaseHelper.getAllSmsLogs();
      emit(MessageDBLoaded(allSms));
    } catch (e) {
      emit(MessageDBError('Failed to get all SMS from DB: $e', e));
    }
  }

  Future<void> _onReadDBSms(
      ReadDBMessage event, Emitter<MessageDBState> emit) async {
    var smsLog = event.sms;
    await smsSeen(sms: event.sms);
    final existingCallLog = await _databaseHelper.getSmsLog(smsLog.id ?? "");
    if (existingCallLog == null) {
      await _databaseHelper.insertSmsLog(smsLog);
    } else {
      var updatedLogId = await _databaseHelper.updateSmsLog(smsLog);
      log("$updatedLogId");
    }
  }
}
