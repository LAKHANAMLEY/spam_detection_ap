import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

class CallLogDBBloc extends Bloc<CallLogDBEvent, CallLogDBState> {
  // Updated Bloc class signature
  final CallLogDBHelper _databaseHelper = CallLogDBHelper.instance;
  // final ContactDBHelper _contactDBHelper = ContactDBHelper.instance;

  CallLogDBBloc() : super(CallLogDBInitial()) {
    // Updated initial state
    on<ImportAllDeviceCallLogs>(_onImportAllCallLogs);
    on<AddDBCallLog>(_onAddCallLogDB);
    on<UpdateDBCallLog>(_onUpdateCallLogDB);
    on<DeleteDBCallLog>(_onDeleteCallLogDB);
    on<DeleteAllDBCallLog>(_onDeleteAllCallLogDB);
    on<LoadDBCallLogs>(_onLoadCallLogDBs);
    // on<LoadDBCallLogById>(_onLoadDBCallLogById);
    on<GetDBCallLog>(_onGetDBCallLog);
    on<SyncDBCallLogs>(_onSyncCallLogsDB);
    on<SyncDBCallLogHistory>(_onSyncDBCallLogHistory);
    on<SyncManuallyDBCallLog>(_onSyncManuallyDBCallLog);
    on<DeleteDBCallLogs>(_onDeleteCallLogsDB);
  }

  Future<void> _onAddCallLogDB(
      AddDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      await _databaseHelper.insertCallLog(event.callLog);
      final callLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(callLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to add call log: $e', e)); // Updated state name
    }
  }

  Future<void> _onUpdateCallLogDB(
      UpdateDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      final callLog = event.callLog;
      final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
      if (existingCallLog == null) {
        await _databaseHelper.insertCallLog(callLog);
      } else {
        await _databaseHelper.updateCallLog(callLog.copyWith(
          isSpam: existingCallLog.isSpam,
          isBlocked: existingCallLog.isBlocked,
          contactListId: existingCallLog.contactListId,
          markspambyuser: existingCallLog.markSpamByUser,
          isMarkedSpamByMe: existingCallLog.isMarkSpamByMe,
          synced: existingCallLog.synced,
          name: (existingCallLog.name?.isEmpty ?? false)
              ? callLog.name
              : existingCallLog.name,
          contactData: existingCallLog.contactData,
        ));
      }
      final callLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(callLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to update call log: $e', e)); // Updated state name
    }
  }

  Future<void> _onGetDBCallLog(
      GetDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      final callLogs = await _databaseHelper.getCallLog(event.mobileNo);
      if (callLogs != null) {
        emit(CallLogDBLoadedById(callLogs));
      } else {
        log("Call log not found by mobile no. ${event.mobileNo}");
      }
    } catch (e) {
      emit(CallLogDBError(
          'Failed to update call log: $e', e)); // Updated state name
    }
  }

  Future<void> _onDeleteCallLogDB(
      DeleteDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      await deleteCallLog(callLog: CallLogData(id: event.callLogId));
      await _databaseHelper.deleteCallLog(event.callLogId);
      final callLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(callLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to delete call log: $e', e)); // Updated state name
    }
  }

  Future<void> _onDeleteAllCallLogDB(
      DeleteAllDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      await deleteAllCallLogs();
      await _databaseHelper.deleteAllCallLogs();
      await _databaseHelper.deleteDatabase1();
      final callLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(callLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to delete call log: $e', e)); // Updated state name
    }
  }

  Future<void> _onLoadCallLogDBs(
      LoadDBCallLogs event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      final callLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(callLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to load call logs: $e', e)); // Updated state name
    }
  }

  // Future<void> _onLoadDBCallLogById(
  //     LoadDBCallLogById event, Emitter<CallLogDBState> emit) async {
  //   // Updated event and state types
  //   emit(CallLogDBLoading()); // Updated state name
  //   try {
  //     final callLog = await _databaseHelper.getCallLog(event.id);
  //     if (callLog == null) {
  //       return;
  //     }
  //     emit(CallLogDBLoadedById(callLog!)); // Updated state name
  //   } catch (e) {
  //     emit(CallLogDBError(
  //         'Failed to load call logs: $e', e)); // Updated state name
  //   }
  // }

  Map<String, List<CallLogEntry>> getGroupedLocalCallLogs(
    List<CallLogEntry> localCallLogs,
  ) {
    Map<String, List<CallLogEntry>> groupedLocalCallLogs = {};
    for (var log in localCallLogs) {
      final phone = log.number?.separatePhoneAndPhoneCode().phone;
      if (phone != null) {
        groupedLocalCallLogs.putIfAbsent(phone, () => []).add(log);
      }
    }
    return groupedLocalCallLogs;
  }

  List<CallLogData> mouldCallLogEntryAsCallLogData(
      Map<String, List<CallLogEntry>> groupedLocalCallLogs,
      List<CallLogData> serverCallLogs,
      Emitter<CallLogDBState> emit) {
    Map<String, CallLogData> serverMessagesMap = {
      for (var msg in serverCallLogs) msg.mobileNo ?? "": msg
      // (msg.countryCode?.isNotEmpty ?? false
      //     ? "+${msg.countryCode!}${msg.mobileNo!}"
      //     : msg.mobileNo!): msg
    };

    List<CallLogData> syncedCallLogs = [];

    for (final phone in groupedLocalCallLogs.keys) {
      final localCallLogList = groupedLocalCallLogs[phone]!;
      final serverLog = serverMessagesMap[phone];
      // List<CallLogData> callHistory = [];

      // // Add local SMS details
      // callHistory.addAll(localCallLogList.map((sms) => CallLogData(
      //       id: sms.number,
      //       mobileNo: sms.number,
      //       callDuration: sms.duration.toString(),
      //       callDurations: sms.duration.toString(),
      //       countryCode: sms.number?.separatePhoneAndPhoneCode().phoneCode,
      //       callDurationUnit: "1",
      //       callTime: sms.timestamp?.toDateTime(),
      //       callType: sms.callType?.name,
      //       simdisplayname: sms.simDisplayName,
      //       phoneaccountid: sms.phoneAccountId,
      //       name: sms.name,
      //     )));

      // Add server SMS details if available (and if a local message with this address exists)
      // if (serverLog?.smsDetails != null) {
      //   smsDetails.addAll(serverLog!.smsDetails!);
      // }

      CallLogEntry? deviceCallLog = localCallLogList.firstOrNull;

      syncedCallLogs.add(
        CallLogData(
          id: phone,
          countryCode:
              deviceCallLog?.number?.separatePhoneAndPhoneCode().phoneCode,
          name: deviceCallLog?.name?.isNotEmpty ?? false
              ? deviceCallLog?.name
              : serverLog?.name, // priority local
          mobileNo: deviceCallLog?.number?.separatePhoneAndPhoneCode().phone,
          callDuration: deviceCallLog?.duration?.toString(),
          callDurations: serverLog?.callDurations.toString(),
          callDurationUnit: "1",
          callTime:
              deviceCallLog?.timestamp?.toDateTime() ?? serverLog?.callTime,
          callType: deviceCallLog?.callType?.name ?? serverLog?.callType,
          simdisplayname: deviceCallLog?.simDisplayName,
          phoneaccountid: deviceCallLog?.phoneAccountId,
          contactListId: serverLog?.contactListId,
          isBlocked: serverLog?.isBlocked,
          isManually: serverLog?.isManually ?? "",
          isSpam: serverLog?.isSpam,
          markSpamByUser: serverLog?.markSpamByUser,
          isMarkSpamByMe: serverLog?.isMarkSpamByMe ?? false,
          contactData: serverLog?.contactData,
        ),
      );

      // Optionally remove from the server map to avoid processing later
      serverMessagesMap.remove(phone);
    }

    // We no longer add any remaining server messages here.

    return syncedCallLogs;
  }

  Future<void> _onSyncCallLogsDB(
      SyncDBCallLogs event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading());
    try {
      await CallLogSyncService.syncCallLogs();
      // List<CallLogEntry> deviceCallLogs =
      //     await CallController.getDeviceCallLogs(
      //         // dateTimeFrom:
      //         //     DateTime.now().subtract(Duration(days: 30 * 6)), //6 months
      //         // dateTimeTo: DateTime.now(),
      //         );

      // Map<String, List<CallLogEntry>> groupedLocalCallLogs =
      //     getGroupedLocalCallLogs(deviceCallLogs);

      // await syncCallLog(
      //     callLogs: groupedLocalCallLogs.values.map((s) => s.first).toList());
      // var res = await getCallLogs();
      // var callLogsData = res.callloglist ?? [];

      // var mouldedLogs = mouldCallLogEntryAsCallLogData(
      //     groupedLocalCallLogs, callLogsData, emit);

      // // log("Moulded call logs : ${mouldedLogs.map((e) => e.toJson()).toList()}");

      // for (final callLog in mouldedLogs) {
      //   final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
      //   if (existingCallLog == null) {
      //     await _databaseHelper.insertCallLog(callLog);
      //   } else {
      //     await _databaseHelper.updateCallLog(callLog);
      //   }
      // }

      final storedCallLogs = await _databaseHelper.getAllCallLogs();

      // log("Call logs (stored in DB) : ${mouldedLogs.map((e) => e.toJson()).toList()}");

      emit(CallLogDBLoaded(storedCallLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to sync and store call logs: $e', e)); // Updated state name
    }
  }

  FutureOr<void> _onSyncDBCallLogHistory(
      SyncDBCallLogHistory event, Emitter<CallLogDBState> emit) async {
    emit(CallLogDBLoading());
    try {
      var callLogs =
          await CallController.getDeviceCallLogs(number: event.mobileNo);
      if (callLogs.isNotEmpty) {
        var resp = await checkSpam(callLogs: callLogs);
        emit(SyncDBCallLogHistoryState(resp));

        var serverContactData = resp.phonespamdetails;

        //TODO: Add in call log db not in contact db

        // update The Contact DB With Latest Details
        // var exist =
        //     await _contactDBHelper.getContact(serverContactData?.mobileNo ?? "");
        // if (exist == null) {
        //   await _contactDBHelper.insert(serverContactData!);
        // } else {
        //   await _contactDBHelper.update(serverContactData!);
        // }

        ///Insert in contact db and call log db also after mounding
        ///
        var groupedLocalCallLogs = getGroupedLocalCallLogs(callLogs);
        var mouldedLogs = mouldCallLogEntryAsCallLogData(
            groupedLocalCallLogs,
            serverContactData?.callHistory
                    ?.map((e) => e.copyWith(
                        isSpam: serverContactData.isSpam,
                        isBlocked: serverContactData.isBlocked,
                        markspambyuser: serverContactData.markspambyuser,
                        isMarkedSpamByMe: serverContactData.isMarkedSpamByMe,
                        contactData: serverContactData
                        //Copy with is due to not getting these params in call history
                        ))
                    .toList() ??
                [],
            emit);

        // log("Moulded call logs : ${mouldedLogs.map((e) => e.toJson()).toList()}");

        for (final callLog in mouldedLogs) {
          final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
          if (existingCallLog == null) {
            await _databaseHelper.insertCallLog(callLog);
          } else {
            // log("Call log detail synced ${callLog.toJson()}");
            await _databaseHelper.updateCallLog(callLog.copyWith(
              // isSpam: existingCallLog.isSpam,
              // isBlocked: existingCallLog.isBlocked,
              // contactListId: existingCallLog.contactListId,
              // markspambyuser: existingCallLog.markSpamByUser,
              // isMarkedSpamByMe: existingCallLog.isMarkSpamByMe,
              // synced: existingCallLog.synced,
              name: (existingCallLog.name?.isEmpty ?? false)
                  ? callLog.name
                  : existingCallLog.name,
              contactData: callLog.contactData,
            ));
          }
        }
      } else {
        log("No call logs history $callLogs");
      }

      final storedCallLogs = await _databaseHelper.getAllCallLogs();

      // log("Call logs (stored in DB) : ${mouldedLogs.map((e) => e.toJson()).toList()}");

      emit(CallLogDBLoaded(storedCallLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to sync and store call logs: $e', e)); // Updated state name
    }
  }

  Future<void> _onSyncManuallyDBCallLog(
      SyncManuallyDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      var log = event.callLogEntry;
      // Iterable<CallLogEntry> deviceCallLogs = await getDeviceCallLogs();
      // var callLogData = await
      syncCallLogManually(callLogs: log);
      // var callLog = callLogData.callLog;
      var callLog = CallLogData(
        id: log.number,
        name: log.name,
        mobileNo: log.number?.separatePhoneAndPhoneCode().phone,
        countryCode: log.number?.separatePhoneAndPhoneCode().phoneCode,
        callDuration: log.duration.toString(),
        callTime: log.timestamp?.toDateTime(),
        callDurationUnit: "1",
        callDurations: log.duration.toString(),
        callType: log.callType?.name,
        contactListId: log.number,
        phoneaccountid: log.phoneAccountId,
        simdisplayname: log.simDisplayName,
      );
      // var res = await getCallLogs();
      // var callLogsData = res.callloglist ?? [];
      // for (final callLog in callLogsData) {
      final existingCallLog =
          await _databaseHelper.getCallLog(callLog.mobileNo ?? "");
      if (existingCallLog == null) {
        await _databaseHelper.insertCallLog(callLog);
      } else {
        await _databaseHelper.updateCallLog(callLog.copyWith(
          isSpam: existingCallLog.isSpam,
          isBlocked: existingCallLog.isBlocked,
          contactListId: existingCallLog.contactListId,
          markspambyuser: existingCallLog.markSpamByUser,
          isMarkedSpamByMe: existingCallLog.isMarkSpamByMe,
          synced: existingCallLog.synced,
          name: (existingCallLog.name?.isEmpty ?? false)
              ? callLog.name
              : existingCallLog.name,
          contactData: existingCallLog.contactData,
        ));
      }
      // }
      // emit(CallLogDBLoading());
      final storedCallLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(storedCallLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to sync and store call logs: $e', e)); // Updated state name
    }
  }

  FutureOr<void> _onDeleteCallLogsDB(
      DeleteDBCallLogs event, Emitter<CallLogDBState> emit) async {
    await _databaseHelper.deleteDatabase1();
    emit(CallLogDBInitial());
  }

  FutureOr<void> _onImportAllCallLogs(
      ImportAllDeviceCallLogs event, Emitter<CallLogDBState> emit) async {
    var deviceCallLogs = await CallController.getDeviceCallLogs();
    Map<String, List<CallLogEntry>> groupedLocalCallLogs =
        getGroupedLocalCallLogs(deviceCallLogs);
    var mouldedCallLogs = groupedLocalCallLogs.values
        .map((s) => CallLogData.fromCallLogEntry(s.first))
        .toList();
    for (final callLog in mouldedCallLogs) {
      final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
      if (existingCallLog == null) {
        await _databaseHelper.insertCallLog(callLog);
      } else {
        await _databaseHelper.updateCallLog(
          callLog.copyWith(
            isSpam: existingCallLog.isSpam,
            isBlocked: existingCallLog.isBlocked,
            contactListId: existingCallLog.contactListId,
            markspambyuser: existingCallLog.markSpamByUser,
            isMarkedSpamByMe: existingCallLog.isMarkSpamByMe,
            synced: existingCallLog.synced,
            name: (existingCallLog.name?.isEmpty ?? false)
                ? callLog.name
                : existingCallLog.name,
            contactData: existingCallLog.contactData,
            // callDuration: existingCallLog.callDuration,
            // callDurationUnit: existingCallLog.callDurationUnit,
            // callDurations: existingCallLog.callDuration,
            // callTime: existingCallLog.callTime,
            // callType: existingCallLog.callType,
            // countryCode: existingCallLog.countryCode,
            // totalcalllog: existingCallLog.totalCallLog,
          ),
        );
      }
    }
    // emit(CallLogDBLoading());
    final storedCallLogs = await _databaseHelper.getAllCallLogs();
    emit(CallLogDBLoaded(storedCallLogs)); // Updated state name
  }
}
