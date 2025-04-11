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
    on<SyncDBCallLogs>(_onSyncCallLogDBs);
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

  Future<void> _onSyncCallLogDBs(
      SyncDBCallLogs event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      Iterable<CallLogEntry> deviceCallLogs = await getDeviceCallLogs();
      await syncCallLog(callLogs: deviceCallLogs.toList());
      var res = await getCallLogs();
      var callLogsData = res.callloglist ?? [];
      for (final callLog in callLogsData) {
        final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
        if (existingCallLog == null) {
          await _databaseHelper.insertCallLog(callLog);
        } else {
          await _databaseHelper.updateCallLog(callLog);
        }
      }

      final storedCallLogs = await _databaseHelper.getAllCallLogs();
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
      // Iterable<CallLogEntry> deviceCallLogs = await getDeviceCallLogs();
      await syncCallLogManually(callLogs: event.callLogEntry);
      var res = await getCallLogs();
      var callLogsData = res.callloglist ?? [];
      for (final callLog in callLogsData) {
        final existingCallLog = await _databaseHelper.getCallLog(callLog.id!);
        if (existingCallLog == null) {
          await _databaseHelper.insertCallLog(callLog);
        } else {
          await _databaseHelper.updateCallLog(callLog);
        }
      }

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
