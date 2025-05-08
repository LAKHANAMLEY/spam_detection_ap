// BLoC Events
import 'package:spam_delection_app/lib.dart';

abstract class MessageDBEvent extends Equatable {
  const MessageDBEvent();

  @override
  List<Object> get props => [];
}

// class LoadSmsLogs extends MessageDBEvent {}

class AddSmsLog extends MessageDBEvent {
  final SmsMessage smsLog;

  const AddSmsLog(this.smsLog);

  @override
  List<Object> get props => [smsLog];
}

class DeleteAllSmsLogs extends MessageDBEvent {
  final SmsLog smsLog;

  const DeleteAllSmsLogs({required this.smsLog});
  @override
  List<Object> get props => [smsLog];
}

class DeleteSmsLog extends MessageDBEvent {
  final String id;

  const DeleteSmsLog({required this.id});
  @override
  List<Object> get props => [id];
}

class DeleteMessageDB extends MessageDBEvent {}

// New Events for Syncing
// class LoadDeviceSms extends MessageDBEvent {}

class ImportAllDeviceMessages extends MessageDBEvent {}

class ImportAllDeviceMessagesDetails extends MessageDBEvent {
  final String threadId;

  const ImportAllDeviceMessagesDetails({required this.threadId});
  @override
  List<Object> get props => [threadId];
}

class PaginateAndSyncMessagesWithServer extends MessageDBEvent {
  final int start;
  final int limit;

  const PaginateAndSyncMessagesWithServer(
      {required this.start, required this.limit});
  @override
  List<Object> get props => [start, limit];
}

// class SyncMessagesWithServer extends MessageDBEvent {}

class SyncMessageDetailsWithServer extends MessageDBEvent {
  final SmsLog smsLogs;

  const SyncMessageDetailsWithServer({required this.smsLogs});
  @override
  List<Object> get props => [smsLogs];
}

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

class GetSmsFromDB extends MessageDBEvent {
  final int start;
  final int limit;

  const GetSmsFromDB({required this.start, required this.limit});

  @override
  List<Object> get props => [start, limit];
}

class GetSmsDetails extends MessageDBEvent {
  final int start;
  final int limit;
  final String id;

  const GetSmsDetails({
    required this.id,
    required this.start,
    required this.limit,
  });

  @override
  List<Object> get props => [start, limit];
}

class ReadDBMessage extends MessageDBEvent {
  final SmsLog sms;

  const ReadDBMessage({required this.sms});

  @override
  List<Object> get props => [sms];
}
