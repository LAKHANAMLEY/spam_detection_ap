// BLoC
import 'package:spam_delection_app/bloc/message_db_bloc/message_db_event.dart';
import 'package:spam_delection_app/bloc/message_db_bloc/message_db_state.dart';
import 'package:spam_delection_app/data/sqflite/message_db_helper.dart';
import 'package:spam_delection_app/lib.dart';

class MessageDBBloc extends Bloc<MessageDBEvent, MessageDBState> {
  final SmsLogDBHandler _databaseHelper = SmsLogDBHandler.instance;

  MessageDBBloc() : super(MessageDBInitial()) {
    // on<LoadSmsLogs>(_onLoadSmsLogs);
    on<AddSmsLog>(_onAddSmsLog);
    on<DeleteSmsLog>(_onDeleteSmsLog);
    on<DeleteAllSmsLogs>(_onDeleteAllSmsLogs);
    on<DeleteMessageDB>(_onDeleteDatabase);
    // on<LoadDeviceSms>(_onLoadDeviceSms);
    on<SyncMessagesWithServer>(_onSyncMessagesWithServer);
    on<AddSmsLogsToDB>(_onAddSmsLogsToDB);
    on<GetAllSmsFromDB>(_onGetAllSmsFromDB);
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
      emit(MessageDBError('Failed to add SMS log to DB: $e'));
    }
  }

  Future<void> _onDeleteAllSmsLogs(
      DeleteAllSmsLogs event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      await _databaseHelper.deleteTable();
      emit(const MessageDBLoaded([]));
    } catch (e) {
      emit(MessageDBError('Failed to delete all SMS logs from DB: $e'));
    }
  }

  Future<void> _onDeleteSmsLog(
      DeleteSmsLog event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      await _databaseHelper.delete(event.id);
      emit(const MessageDBLoaded([]));
    } catch (e) {
      emit(MessageDBError('Failed to delete all SMS logs from DB: $e'));
    }
  }

  Future<void> _onDeleteDatabase(
      DeleteMessageDB event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      await _databaseHelper.deleteDatabase1();
      emit(MessageDBInitial());
    } catch (e) {
      emit(MessageDBError('Failed to delete the database: $e'));
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

  Future<void> _onSyncMessagesWithServer(
      SyncMessagesWithServer event, Emitter<MessageDBState> emit) async {
    emit(MessageDBSyncing());
    try {
      final localSmsLogs = await getDeviceSms();
      await syncSmsWithServer(smsLogs: localSmsLogs);
      final resp = await smsList();
      final serverMessages = resp.smsLog ?? [];
      for (final smsLog in serverMessages) {
        final existingCallLog =
            await _databaseHelper.getSmsLog(smsLog.id ?? "");
        if (existingCallLog == null) {
          await _databaseHelper.insertSmsLog(smsLog);
        } else {
          await _databaseHelper.updateSmsLog(smsLog);
        }
      }
      final syncedSmsLogs = await _databaseHelper.getAllSmsLogs();

      emit(MessageDBLoaded(syncedSmsLogs));
    } catch (e) {
      emit(MessageDBError('Failed to sync messages with server: $e'));
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
      emit(MessageDBError('Failed to add SMS logs to DB: $e'));
    }
  }

  Future<void> _onGetAllSmsFromDB(
      GetAllSmsFromDB event, Emitter<MessageDBState> emit) async {
    emit(MessageDBLoading());
    try {
      final allSms = await _databaseHelper.getAllSmsLogs();
      emit(MessageDBLoaded(allSms));
    } catch (e) {
      emit(MessageDBError('Failed to get all SMS from DB: $e'));
    }
  }
}
