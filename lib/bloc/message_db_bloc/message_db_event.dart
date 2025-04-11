// BLoC Events
import 'package:spam_delection_app/lib.dart';

abstract class MessageDBEvent extends Equatable {
  const MessageDBEvent();

  @override
  List<Object> get props => [];
}

// class LoadSmsLogs extends MessageDBEvent {}

class AddSmsLog extends MessageDBEvent {
  final SmsLog smsLog;

  const AddSmsLog(this.smsLog);

  @override
  List<Object> get props => [smsLog];
}

class DeleteAllSmsLogs extends MessageDBEvent {}

class DeleteSmsLog extends MessageDBEvent {
  final String id;

  const DeleteSmsLog({required this.id});
  @override
  List<Object> get props => [id];
}

class DeleteMessageDB extends MessageDBEvent {}

// New Events for Syncing
// class LoadDeviceSms extends MessageDBEvent {}

class SyncMessagesWithServer extends MessageDBEvent {}

class SyncChangedMessageWithServer extends MessageDBEvent {
  final SmsMessage smsMessage;

  const SyncChangedMessageWithServer({required this.smsMessage});

  @override
  List<Object> get props => [smsMessage];
}

class AddSmsLogsToDB extends MessageDBEvent {
  final List<SmsLog> smsLogs;

  const AddSmsLogsToDB(this.smsLogs);

  @override
  List<Object> get props => [smsLogs];
}

class GetAllSmsFromDB extends MessageDBEvent {}
