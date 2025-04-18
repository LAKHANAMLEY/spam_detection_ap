import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

class CallLogDBBloc extends Bloc<CallLogDBEvent, CallLogDBState> {
  // Updated Bloc class signature
  final CallLogDBHelper _databaseHelper = CallLogDBHelper.instance;

  CallLogDBBloc() : super(CallLogDBInitial()) {
    // Updated initial state
    on<AddDBCallLog>(_onAddCallLogDB);
    on<UpdateDBCallLog>(_onUpdateCallLogDB);
    on<DeleteDBCallLog>(_onDeleteCallLogDB);
    on<DeleteAllDBCallLog>(_onDeleteAllCallLogDB);
    on<LoadDBCallLogs>(_onLoadCallLogDBs);
    on<GetDBCallLog>(_onGetDBCallLog);
    on<SyncDBCallLogs>(_onSyncCallLogsDB);
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
      await _databaseHelper.updateCallLog(event.callLog);
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
      final callLogs =
          await _databaseHelper.getCallLog(event.callLogData.mobileNo ?? "");
      emit(CallLogDBLoaded([callLogs!])); // Updated state name
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

  Map<String, List<CallLogEntry>> getGroupedLocalCallLogs(
    List<CallLogEntry> localCallLogs,
  ) {
    Map<String, List<CallLogEntry>> groupedLocalCallLogs = {};
    for (var log in localCallLogs) {
      final address = log.number;
      if (address != null) {
        groupedLocalCallLogs.putIfAbsent(address, () => []).add(log);
      }
    }
    return groupedLocalCallLogs;
  }

  List<CallLogData> mouldCallLogEntryAsCallLogData(
      Map<String, List<CallLogEntry>> groupedLocalCallLogs,
      List<CallLogData> serverCallLogs,
      Emitter<CallLogDBState> emit) {
    Map<String, CallLogData> serverMessagesMap = {
      for (var msg in serverCallLogs)
        (msg.countryCode?.isNotEmpty ?? false
            ? "+${msg.countryCode!}${msg.mobileNo!}"
            : msg.mobileNo!): msg
    };

    List<CallLogData> syncedCallLogs = [];

    for (final address in groupedLocalCallLogs.keys) {
      final localCallLogList = groupedLocalCallLogs[address]!;
      final serverLog = serverMessagesMap[address];
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

      syncedCallLogs.add(
        // CallLogData(
        //   id: serverLog?.id ?? address,
        //   countryCode: serverLog?.countryCode,
        //   name: serverLog?.name ?? localCallLogList.firstOrNull?.name,
        //   mobileNo: serverLog?.mobileNo,
        //   callDuration: serverLog?.callDuration?.toString(),
        //   callDurations: serverLog?.callDurations.toString(),
        //   callDurationUnit: "1",
        //   callTime: serverLog?.callTime,
        //   callType: serverLog?.callType,
        //   simdisplayname: serverLog?.simdisplayname,
        //   phoneaccountid: serverLog?.phoneaccountid,
        //   contactListId: serverLog?.contactListId,
        //   isBlocked: serverLog?.isBlocked,
        //   isManually: serverLog?.isManually ?? "",
        //   isSpam: serverLog?.isSpam,
        //   markSpamByUser: serverLog?.markSpamByUser,
        // ),
        CallLogData(
          id: serverLog?.id ?? address,
          countryCode: serverLog?.countryCode,
          name: localCallLogList.firstOrNull?.name?.isNotEmpty ?? false
              ? localCallLogList.firstOrNull?.name
              : serverLog?.name, // priority local
          mobileNo: serverLog?.mobileNo,
          callDuration: serverLog?.callDuration?.toString(),
          callDurations: serverLog?.callDurations.toString(),
          callDurationUnit: "1",
          callTime: localCallLogList.firstOrNull?.timestamp?.toDateTime() ??
              serverLog?.callTime,
          callType: localCallLogList.firstOrNull?.callType?.name ??
              serverLog?.callType,
          simdisplayname: serverLog?.simdisplayname,
          phoneaccountid: serverLog?.phoneaccountid,
          contactListId: serverLog?.contactListId,
          isBlocked: serverLog?.isBlocked,
          isManually: serverLog?.isManually ?? "",
          isSpam: serverLog?.isSpam,
          markSpamByUser: serverLog?.markSpamByUser,
        ),
      );

      // Optionally remove from the server map to avoid processing later
      serverMessagesMap.remove(address);
    }

    // We no longer add any remaining server messages here.

    return syncedCallLogs;
  }

  Future<void> _onSyncCallLogsDB(
      SyncDBCallLogs event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      List<CallLogEntry> deviceCallLogs = await getDeviceCallLogs(
        dateTimeFrom:
            DateTime.now().subtract(Duration(days: 30 * 6)), //6 months
        dateTimeTo: DateTime.now(),
      );

      Map<String, List<CallLogEntry>> groupedLocalCallLogs =
          getGroupedLocalCallLogs(deviceCallLogs);

      ///here we are emitting the local data
      // emit(CallLogDBLoaded(groupedLocalCallLogs.keys.map((key) {
      //   var e = groupedLocalCallLogs[key]!.first;
      //   return CallLogData(
      //     name: e.name,
      //     countryCode: e.number?.separatePhoneAndPhoneCode().phoneCode,
      //     mobileNo: e.number?.separatePhoneAndPhoneCode().phone,
      //     callType: e.callType?.name,
      //     callDuration: e.duration.toString(),
      //     callDurations: e.duration.toString(),
      //     callDurationUnit: "1",
      //     callTime: e.timestamp?.toDateTime(),
      //     phoneaccountid: e.phoneAccountId,
      //     simdisplayname: e.simDisplayName,
      //     isManually: "1",

      //     ///rest of the things we weill update from server after sync
      //   );
      // }).toList()));

      await syncCallLog(callLogs: deviceCallLogs.toList());
      var res = await getCallLogs();
      var callLogsData = res.callloglist ?? [];

      var mouldedLogs = mouldCallLogEntryAsCallLogData(
          groupedLocalCallLogs, callLogsData, emit);

      // log("Moulded call logs : ${mouldedLogs.map((e) => e.toJson()).toList()}");

      for (final callLog in mouldedLogs) {
        final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
        if (existingCallLog == null) {
          await _databaseHelper.insertCallLog(callLog);
        } else {
          await _databaseHelper.updateCallLog(callLog);
        }
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
          await _databaseHelper.getCallLog(callLog.id ?? "");
      if (existingCallLog == null) {
        await _databaseHelper.insertCallLog(callLog);
      } else {
        await _databaseHelper.updateCallLog(callLog);
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
}
