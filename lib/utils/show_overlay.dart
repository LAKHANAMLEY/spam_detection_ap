import 'package:spam_delection_app/lib.dart';
import 'package:system_alert_window/system_alert_window.dart';

showOverlay(
    {required String callType,
    required String number,
    required int duration}) async {
  print('$callType, number: $number, duration: $duration s');
  SystemAlertWindow.sendMessageToOverlay(callLogData(
    mobileNo: number,
    callDuration: duration.toString(),
  ).toJson());
  await SystemAlertWindow.showSystemWindow(
    notificationTitle: AppConstants.projectName,
    notificationBody: "Incoming call $number",
  );
}
