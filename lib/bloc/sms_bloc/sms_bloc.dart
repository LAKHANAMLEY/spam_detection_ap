// Bloc
import 'dart:developer';

import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc_event.dart';
import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc_state.dart';
import 'package:spam_delection_app/globals/index.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final SmsReceiver _receiver = SmsReceiver();
  StreamSubscription<SmsMessage>? _smsSubscription;

  SmsBloc() : super(SmsInitial()) {
    on<StartListeningSms>(_onStartListeningSms);
    on<SmsReceived>(_onSmsReceived);
  }

  Future<void> _onStartListeningSms(
      StartListeningSms event, Emitter<SmsState> emit) async {
    emit(SmsListening());
    try {
      _smsSubscription = _receiver.onSmsReceived?.listen((SmsMessage msg) {
        log(msg.toString());
        add(SmsReceived(msg));
      });
    } catch (e) {
      log(e.toString());
      emit(SmsError(e.toString()));
    }
  }

  Future<void> _onSmsReceived(SmsReceived event, Emitter<SmsState> emit) async {
    emit(NewSmsReceived(event.message));
  }

  @override
  Future<void> close() {
    _smsSubscription?.cancel();
    return super.close();
  }
}
