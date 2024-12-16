import 'package:spam_delection_app/lib.dart';

class NotificationListItem extends StatelessWidget {
  final List<String> entries = <String>['1', '2', '3', '4', '5', '6', '7', '8'];

  final NotificationTypeData notification;

  NotificationListItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: entries.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          CustomListTile(
            onTap: () {},
            leading: const CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage(IconConstants.icNotification),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification ${entries[index]}',
                ),
                10.width(),
                Text(
                  notification.callTime?.formatDateTime() ?? "",
                  style: textTheme(context)
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
            subtitle: const Text('You are in spam detection app'),

            // trailing: Text(callLog.callTime?.formatDateTime() ?? ""),
          );
          return null;
        });
  }
}
