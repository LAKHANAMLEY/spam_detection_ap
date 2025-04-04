import 'package:spam_delection_app/globals/index.dart';

// Events
abstract class SmsEvent {}

class StartListeningSms extends SmsEvent {}

class SmsReceived extends SmsEvent {
  final SmsMessage message;

  SmsReceived(this.message);
}
