import 'package:sms_advanced/sms_advanced.dart';

listenSmsReceived() {
  SmsReceiver sender = SmsReceiver();
  sender.onSmsReceived?.listen((SmsMessage message) {
    print('${message.address} received your message.');
  });
}
