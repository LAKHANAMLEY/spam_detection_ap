import 'package:spam_delection_app/lib.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationData notification;

  const NotificationListItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        /*Navigator.pushNamed(context, AppRoutes.contactDetail,
            arguments: ContactDetail(
              contact: ContactData(
                countryCode: callLog.countryCode,
                mobileNo: callLog.mobileNo,
                name: callLog.name,
                numberType: callLog.callType,
                id: callLog.contactListId,
                isSpam: callLog.isSpam,
                isBlocked: callLog.isBlocked,
                markspambyuser: callLog.markSpamByUser,
              ),
            ));

         */
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
              notification.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColor.callColor),
            ),
          ),
          10.width(),
          Text(
            notification.createdDate?.formatDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text(notification.id.toString()),
      /*
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text(
          //   callLog.callTime?.formatDateTime() ?? "",
          //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          // ),
          PopupMenuButton(
            menuPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            // position: ,
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: AppColor.secondryColor,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                      builder: (BuildContext context) {
                        return ReportView(
                          contact: ContactData(
                            id: notification.contactListId,
                            mobileNo: notification.mobileNo,
                            name: notification.name,
                            isSpam: notification.isSpam,
                            countryCode: notification.countryCode,
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Report")),
              PopupMenuItem(
                  onTap: () {
                    markSpamBloc.add(BlockUnBlockEvent(
                        contactId: notification.mobileNo ?? "",
                        comments: "block"));
                  },
                  child:
                      Text(notification.isBlocked == 1 ? "Unblock" : "Block"))
            ],
          ),
        ],
      ),
      */
      // trailing: Text(callLog.callTime?.formatDateTime() ?? ""),
    );
  }
}
