import 'package:spam_delection_app/lib.dart';

abstract class CallLogDBState extends Equatable {
  // Renamed class
  const CallLogDBState();

  @override
  List<Object> get props => [];
}

class CallLogDBInitial extends CallLogDBState {} // States remain the same

class CallLogDBLoading extends CallLogDBState {} // States remain the same

class CallLogDBLoaded extends CallLogDBState {
  // States remain the same
  final List<CallLogData> callLogs;

  const CallLogDBLoaded(this.callLogs);

  @override
  List<Object> get props => [callLogs];
}

class CallLogDBError extends CallLogDBState {
  // States remain the same
  final String message;
  final Object exception;

  const CallLogDBError(this.message, this.exception);

  @override
  List<Object> get props => [message, exception];
}
