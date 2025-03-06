import 'package:spam_delection_app/lib.dart';
import 'package:url_launcher/url_launcher.dart';

launchSms(BuildContext context, String mobileNo) async {
  try {
    if (Platform.isAndroid) {
      String uri = 'sms:$mobileNo?body=${Uri.encodeComponent("Hello there")}';
      await launchUrl(Uri.parse(uri));
    } else if (Platform.isIOS) {
      String uri = 'sms:$mobileNo&body=${Uri.encodeComponent("Hello there")}';
      await launchUrl(Uri.parse(uri));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appLocalization(context).someOccurredAgain),
      ),
    );
  }
}
