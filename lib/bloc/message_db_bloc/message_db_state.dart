import 'package:equatable/equatable.dart';
import 'package:spam_delection_app/models/sms/sms_list_model.dart';

// Models (Assuming these are in separate files or defined above)
// ... (SmsLog and SmsDetail classes remain the same)

// Database Helper (Assuming this is in a separate file or defined above)
// ... (SmsLogDatabaseHelper class remains the same)

// BLoC Events (Defined above)

// BLoC States
abstract class MessageDBState extends Equatable {
  const MessageDBState();

  @override
  List<Object> get props => [];
}

class MessageDBInitial extends MessageDBState {}

class MessageDBLoading extends MessageDBState {}

class NewMessageReceived extends MessageDBState {
  final List<SmsLog> smsLogs;

  const NewMessageReceived(this.smsLogs);

  @override
  List<Object> get props => [smsLogs];
}

class MessageDBLoaded extends MessageDBState {
  final List<SmsLog> smsLogs;

  const MessageDBLoaded(this.smsLogs);

  @override
  List<Object> get props => [smsLogs];
}

// class MessageDBSyncing extends MessageDBState {}

class MessageDBSynced extends MessageDBState {
  final List<SmsLog> syncedSmsLogs;

  const MessageDBSynced(this.syncedSmsLogs);

  @override
  List<Object> get props => [syncedSmsLogs];
}

class MessageDBError extends MessageDBState {
  final String message;
  final Object exception;

  const MessageDBError(this.message, this.exception);

  @override
  List<Object> get props => [message, exception];
}

class MessageDBDeletedAllConversation extends MessageDBState {}

class MessageDBDeletedAll extends MessageDBState {}

class MessageDBDeletedById extends MessageDBState {
  final SmsLog smsLog;

  const MessageDBDeletedById({required this.smsLog});
  @override
  List<Object> get props => [smsLog];
}
