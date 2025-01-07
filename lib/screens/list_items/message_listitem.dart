import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/messages_detail.dart';

class MessageListItem extends StatelessWidget {
  final SmsMessage sms;
  const MessageListItem({super.key, required this.sms});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        // print(sms.kind?.name);
        Navigator.pushNamed(context, AppRoutes.messagesDetail,
            arguments: MessagesDetail(sms: sms));
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage(IconConstants.icMessageLock),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            sms.sender ?? "",
            style: textTheme(context).titleMedium,
          ),
          10.width(),
          Text(
            sms.date?.formatRelativeDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Expanded(
          child: Text(
        sms.body ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      )),
      // trailing: const Icon(
      //   Icons.arrow_forward_ios,
      // ),
    );
  }
}
