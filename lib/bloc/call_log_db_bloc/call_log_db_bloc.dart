import 'package:spam_delection_app/bloc/call_log_db_bloc/call_log_db_event.dart';
import 'package:spam_delection_app/bloc/call_log_db_bloc/call_log_db_state.dart';
import 'package:spam_delection_app/data/sqflite/call_log_db_helper.dart';
import 'package:spam_delection_app/lib.dart';

class CallLogDBBloc extends Bloc<CallLogDBEvent, CallLogDBState> {
  // Updated Bloc class signature
  final CallLogDBHelper _databaseHelper = CallLogDBHelper.instance;

  CallLogDBBloc() : super(CallLogDBInitial()) {
    // Updated initial state
    on<AddDBCallLog>(_onAddCallLogDB);
    on<UpdateDBCallLog>(_onUpdateCallLogDB);
    on<DeleteDBCallLog>(_onDeleteCallLogDB); // Updated event handler name
    on<LoadDBCallLogs>(_onLoadCallLogDBs); // Updated event handler name
    on<SyncDBCallLogs>(_onSyncCallLogDBs); // Updated event handler name
    on<DeleteDBCallLogs>(_onDeleteCallLogsDB); // Updated event handler name
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
      emit(CallLogDBError('Failed to add call log: $e')); // Updated state name
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
          'Failed to update call log: $e')); // Updated state name
    }
  }

  Future<void> _onDeleteCallLogDB(
      DeleteDBCallLog event, Emitter<CallLogDBState> emit) async {
    // Updated event and state types
    emit(CallLogDBLoading()); // Updated state name
    try {
      await _databaseHelper.deleteCallLog(event.callLogId);
      final callLogs = await _databaseHelper.getAllCallLogs();
      emit(CallLogDBLoaded(callLogs)); // Updated state name
    } catch (e) {
      emit(CallLogDBError(
          'Failed to delete call log: $e')); // Updated state name
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
      emit(
          CallLogDBError('Failed to load call logs: $e')); // Updated state name
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
          'Failed to sync and store call logs: $e')); // Updated state name
    }
  }

  String? _mapCallType(CallType? callType) {
    switch (callType) {
      case CallType.incoming:
        return 'INCOMING';
      case CallType.outgoing:
        return 'OUTGOING';
      case CallType.missed:
        return 'MISSED';
      case CallType.rejected:
        return 'REJECTED';
      case CallType.blocked:
        return 'BLOCKED';
      case CallType.voiceMail:
        return 'VOICEMAIL';
      case CallType.answeredExternally:
        return 'ANSWERED_EXTERNALLY';
      default:
        return null;
    }
  }

  FutureOr<void> _onDeleteCallLogsDB(
      DeleteDBCallLogs event, Emitter<CallLogDBState> emit) async {
    await _databaseHelper.deleteDatabase1();
    emit(CallLogDBInitial());
  }
}
