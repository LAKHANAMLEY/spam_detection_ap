import 'package:spam_delection_app/lib.dart';
import 'package:system_alert_window/system_alert_window.dart';

showOverlay(
    {required String callType,
    required String number,
    required int duration}) async {
  SystemAlertWindow.sendMessageToOverlay({
    "call_type": callType,
    "mobile_no": number,
    "call_duration": duration.toString(),
  });
  await SystemAlertWindow.showSystemWindow(
      notificationTitle: AppConstants.projectName,
      notificationBody: "$callType $number",
      prefMode: SystemWindowPrefMode.BUBBLE);
}
