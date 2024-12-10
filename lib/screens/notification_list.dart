import 'package:spam_delection_app/lib.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notification List",
      ),
      backgroundColor: AppColor.secondryColor,
      body: Column(
        children: [
          CustomListTile(
            title: Text("Notification1"),
            subtitle: Text("You are spam detection app"),
            leading: CircleAvatar(
                backgroundImage: AssetImage(IconConstants.icNotification)),
          )
        ],
      ),
    );
  }
}
