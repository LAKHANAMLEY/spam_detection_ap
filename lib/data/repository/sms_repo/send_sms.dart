import 'package:sms_advanced/sms_advanced.dart';

Future<SmsMessage?> sendSmsByDevice(SmsMessage sms) {
  try {
    SmsSender sender = SmsSender();
    return sender.sendSms(sms);
  } catch (e) {
    throw Exception(e);
  }
}
