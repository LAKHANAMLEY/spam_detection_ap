import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/sms_spam_list_model.dart';

class SmsSpamListItem extends StatelessWidget {
  final SmsSpamList spamSms;

  const SmsSpamListItem({super.key, required this.spamSms});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.messagesDetail,
            arguments: MessagesDetail(
              sms: SmsLog(address: spamSms.address),
              // spamMessage: spamSms.spamMessage,
              // name: spamSms.name,
              //  isSpam: '1',
            ));
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage(IconConstants.icFraud),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              (spamSms.name?.isNotEmpty ?? false)
                  ? spamSms.name ?? ""
                  : spamSms.countryCode?.isNotEmpty ?? false
                      ? "+${spamSms.countryCode} ${spamSms.address ?? ""}"
                      : spamSms.address ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).titleMedium,
            ),
            /*
          10.width(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(
              spamSms.categoryName ?? "",
              style:
                  textTheme(context).bodySmall?.copyWith(color: Colors.white),
            ),
          ),
          */
          ),
        ],
      ),
      subtitle: (spamSms.address?.isEmpty ?? true)
          ? null
          : Text(
              spamSms.address ?? "",
              style: textTheme(context).bodySmall,
            ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
              child: Text(appLocalization(context).removeSpam),
              onTap: () {
                markSpamSmsBloc
                    .add(RemoveSpamSmsEvent(address: spamSms.address ?? ""));
              }),
        ],
      ),
    );
  }
}
