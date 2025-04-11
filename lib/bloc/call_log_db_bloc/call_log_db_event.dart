import 'package:spam_delection_app/lib.dart';

abstract class CallLogDBEvent extends Equatable {
  const CallLogDBEvent();

  @override
  List<Object> get props => [];
}

class AddDBCallLog extends CallLogDBEvent {
  final CallLogData callLog;

  const AddDBCallLog(this.callLog);

  @override
  List<Object> get props => [callLog];
}

class UpdateDBCallLog extends CallLogDBEvent {
  final CallLogData callLog;

  const UpdateDBCallLog(this.callLog);

  @override
  List<Object> get props => [callLog];
}

class DeleteDBCallLog extends CallLogDBEvent {
  final String callLogId;

  const DeleteDBCallLog(this.callLogId);

  @override
  List<Object> get props => [callLogId];
}

class DeleteAllDBCallLog extends CallLogDBEvent {}

class LoadDBCallLogs extends CallLogDBEvent {}

// New event for syncing call logs
class SyncDBCallLogs extends CallLogDBEvent {}

class SyncManuallyDBCallLog extends CallLogDBEvent {
  final CallLogEntry callLogEntry;

  const SyncManuallyDBCallLog({required this.callLogEntry});

  @override
  List<Object> get props => [callLogEntry];
}

class DeleteDBCallLogs extends CallLogDBEvent {}
