import 'package:sms_advanced/sms_advanced.dart';

Future<SmsMessage?> sendSms(phone, message) {
  SmsSender sender = SmsSender();
  return sender.sendSms(SmsMessage(phone, message));
}
