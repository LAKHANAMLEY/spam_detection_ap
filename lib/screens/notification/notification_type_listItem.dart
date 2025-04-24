import 'package:spam_delection_app/lib.dart';

class NotificationTypeListItem extends StatefulWidget {
  final NotificationTypeData notification;

  NotificationTypeListItem({
    super.key,
    required this.notification,
  });

  @override
  State<NotificationTypeListItem> createState() =>
      _NotificationTypeListItemState();
}

class _NotificationTypeListItemState extends State<NotificationTypeListItem> {
  bool isEnabled = false;

  void onToggle(bool value) {
    setState(() {
      isEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.notificationSetting,
            arguments: NotificationSetting(notification: widget.notification));

        // if (notification.is == "0") {
        //   ///call read api
        //   notificationListBloc.add(
        //       ReadNotificationEvent(notificationId: notification.id ?? ""));
        // }
        // navigateByType(RemoteMessage(data: notification.toJson()), context);
        // Navigator.pushNamed(context, AppRoutes.viewedProfile);
      },
      leading: const CircleAvatar(
          radius: 12,
          backgroundImage: AssetImage(IconConstants.icNotification)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.notification.name ?? "",
              style: TextStyle(
                  fontWeight: widget.notification.isNotificationReceive == "1"
                      ? FontWeight.normal
                      : FontWeight.w600,
                  color: AppColor.darkPurpleColor),
            ),
          ),
          // Transform.scale(
          //   scale: 0.8,
          //   child: Switch(
          //     value: isEnabled,
          //     onChanged: onToggle,
          //     inactiveTrackColor: AppColor.whiteColor,
          //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          // ),
        ],
      ),
      // subtitle: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Expanded(
      //         child: Text(
      //           widget.notification.name ?? "",
      //           style: TextStyle(
      //               fontWeight:
      //                   widget.notification.isNotificationReceive == "1"
      //                       ? FontWeight.normal
      //                       : FontWeight.w600,
      //               color: AppColor.darkPurpleColor),
      //         ),
      //       ),
      //       Transform.scale(
      //         scale: 0.8,
      //         child: Switch(
      //           value: isEnabled,
      //           onChanged: onToggle,
      //           inactiveTrackColor: AppColor.whiteColor,
      //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //         ),

      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: isEnabled,
          onChanged: onToggle,
          inactiveTrackColor: AppColor.whiteColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
