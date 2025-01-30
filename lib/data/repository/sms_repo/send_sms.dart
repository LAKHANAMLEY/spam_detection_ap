import 'package:sms_advanced/sms_advanced.dart';

Future<SmsMessage?> sendSms(phone, message) {
  try {
    SmsSender sender = SmsSender();
    return sender.sendSms(SmsMessage(phone, message));
  } catch (e) {
    throw Exception(e);
  }
}
