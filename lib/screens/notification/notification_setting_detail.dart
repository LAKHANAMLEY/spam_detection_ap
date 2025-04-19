import 'package:spam_delection_app/lib.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool isEnabled = false;

  void onToggle(bool value) {
    setState(() {
      isEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var notification
    return Scaffold(
      appBar: CustomAppBar(title: "Notification Details"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              // height: MediaQuery.of(context).size.height * 6 / 100,
              // width: MediaQuery.of(context).size.width * 90 / 100,
              //margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalization(context).allowNotification,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: isEnabled,
                    onChanged: onToggle,
                    inactiveTrackColor: AppColor.whiteColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
            8.height(),
            Container(
              padding: EdgeInsets.all(8),
              // height: MediaQuery.of(context).size.height * 6 / 100,
              // width: MediaQuery.of(context).size.width * 90 / 100,
              //margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalization(context).allowPushNotification,
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: isEnabled,
                    onChanged: onToggle,
                    inactiveTrackColor: AppColor.whiteColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
