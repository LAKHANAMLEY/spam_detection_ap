import 'package:spam_delection_app/lib.dart';

class MessageListItem extends StatelessWidget {
  final SmsLog sms;

  const MessageListItem({super.key, required this.sms});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        // print(sms.kind?.name);
        Navigator.pushNamed(context, AppRoutes.messagesDetail,
            arguments: MessagesDetail(sms: sms));
      },
      leading: Card(
        // shape: BoxShape.circle,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            sms.isSpam == "1"
                ? IconConstants.icSpamMessage
                : IconConstants.icMessageLock,
            width: 40,
            fit: BoxFit.contain,
          ),
        ),
      ),
      // leading: CircleAvatar(
      //   backgroundImage: AssetImage(
      //     sms.isMarkSpam == 1
      //         ? IconConstants.icSpamAlertMessage
      //         : IconConstants.icMessageLock,
      //   ),
      // ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              (sms.name?.isNotEmpty ?? false)
                  ? sms.name ?? ""
                  : sms.address ?? "",
              // : sms.countryCode?.isNotEmpty ?? false
              //     ? "+${sms.countryCode} ${sms.address ?? ""}"
              //     : sms.address ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).titleMedium?.copyWith(
                  fontWeight:
                      sms.unreadReceivedSms == 1 ? FontWeight.bold : null),
            ),
          ),
          10.width(),
          Text(
            sms.date?.formatDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(
                color: Colors.grey,
                fontWeight:
                    sms.unreadReceivedSms == 1 ? FontWeight.bold : null),
          ),
        ],
      ),
      subtitle: Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sms.smsDetails?.isNotEmpty ?? false
                ? sms.smsDetails?.first.body ?? ""
                : "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme(context).bodyMedium?.copyWith(
                fontWeight:
                    sms.unreadReceivedSms == 1 ? FontWeight.bold : null),
          ),
          // if (sms.isMarkSpam == 1)
          //   Text(
          //     sms.smsDetails?.first.spamMessage ?? "",
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //     style: textTheme(context).bodySmall?.copyWith(color: Colors.red),
          //   ),
        ],
      )),
      // trailing: const Icon(
      //   Icons.arrow_forward_ios,
      // ),
    );
  }
}
