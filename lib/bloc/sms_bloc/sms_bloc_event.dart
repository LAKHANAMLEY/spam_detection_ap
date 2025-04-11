import 'package:spam_delection_app/globals/index.dart';

// Events
abstract class SmsEvent extends Equatable {}

class StartListeningSms extends SmsEvent {
  @override
  List<Object?> get props => [];
}

class SmsReceived extends SmsEvent {
  final SmsMessage message;

  SmsReceived(this.message);
  @override
  List<Object?> get props => [message];
}

class SmsSent extends SmsEvent {
  final SmsMessage message;

  SmsSent(this.message);
  @override
  List<Object?> get props => [message];
}
