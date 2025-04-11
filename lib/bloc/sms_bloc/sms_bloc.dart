// Bloc
import 'dart:developer';

import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc_event.dart';
import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc_state.dart';
import 'package:spam_delection_app/globals/index.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final SmsReceiver _receiver = SmsReceiver();
  final SmsSender _sender = SmsSender();
  StreamSubscription<SmsMessage>? _smsRSubscription;
  StreamSubscription<SmsMessage?>? _smsSSubscription;

  SmsBloc() : super(SmsInitial()) {
    on<StartListeningSms>(_onStartListeningSms);
    on<SmsReceived>(_onSmsReceived);
    on<SmsSent>(_onSmsSent);
  }

  Future<void> _onStartListeningSms(
      StartListeningSms event, Emitter<SmsState> emit) async {
    emit(SmsListening());
    try {
      _smsRSubscription = _receiver.onSmsReceived?.listen((SmsMessage msg) {
        log(msg.toString());
        add(SmsReceived(msg));
      });
      _smsSSubscription = _sender.onSmsDelivered.listen((SmsMessage? msg) {
        log(msg.toString());
        if (msg != null) add(SmsSent(msg));
      });
    } catch (e) {
      log(e.toString());
      emit(SmsError(e.toString()));
    }
  }

  Future<void> _onSmsReceived(SmsReceived event, Emitter<SmsState> emit) async {
    emit(NewSmsReceived(event.message));
  }

  Future<void> _onSmsSent(SmsSent event, Emitter<SmsState> emit) async {
    emit(NewSmsSent(event.message));
  }

  @override
  Future<void> close() {
    _smsRSubscription?.cancel();
    _smsSSubscription?.cancel();
    return super.close();
  }
}
