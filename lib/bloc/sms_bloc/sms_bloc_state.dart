import 'package:spam_delection_app/globals/index.dart';

abstract class SmsState {}

class SmsInitial extends SmsState {}

class SmsListening extends SmsState {}

class NewSmsReceived extends SmsState {
  final SmsMessage message;

  NewSmsReceived(this.message);
}

class NewSmsSent extends SmsState {
  final SmsMessage message;

  NewSmsSent(this.message);
}

class SmsError extends SmsState {
  final String error;

  SmsError(this.error);
}
