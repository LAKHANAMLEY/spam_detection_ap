import 'package:spam_delection_app/lib.dart';

import 'blocked_sms_screen.dart';

class MessagesDetail extends StatelessWidget {
  final SmsLog? sms;

  const MessagesDetail({super.key, this.sms});

  get messagesBloc => null;

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as MessagesDetail;
    var sms = arg.sms;
    return Scaffold(
      appBar: CustomAppBar(title: sms?.name, actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                //Navigator.pushNamed(context, AppRoutes.callLogs,
                //    arguments:
                //     DeviceCallLogs(filterBy: CallType.outgoing.name));
              },
              child: Row(
                children: [
                  Image.asset(
                    IconConstants.icSearchCheck,
                    color: AppColor.greyColor,
                    scale: 2,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  Text(
                    appLocalization(context).searchInConversation,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
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
                    return BlockSmsView(
                      sms: SmsDetail(
                        address: SmsLog().address,
                        spamMessage: SmsDetail().spamMessage,
                      ),
                    );

                    /*BlockSmsView(
                      contact: SmsDetail(
                        address: SmsLog().address,
                        /* name: SmsLog.name,
                        isSpam: callLog.isSpam,
                        countryCode: callLog.countryCode,
                      ),

                        */
                      ),
                    );
                    */
                  },
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    IconConstants.icBlockedCall,
                    scale: 2.5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  Text(
                    appLocalization(context).blockSms,
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () {
                messagesBloc.add(DeleteConversationEvent(address: ''));
              },
              child: Row(
                children: [
                  Image.asset(
                    IconConstants.icDelete,
                    color: AppColor.redColor,
                    scale: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  Text(
                    appLocalization(context).deleteConversation,
                    style: const TextStyle(
                        color: AppColor.redColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
      body: ListView.builder(
        itemCount: sms?.smsDetails?.length,
        itemBuilder: (context, index) => MessageView(
          sms: sms?.smsDetails?[index],
        ),
      ),
    );
  }
}

class MessageView extends StatelessWidget {
  final SmsDetail? sms;

  const MessageView({super.key, this.sms});

  @override
  Widget build(BuildContext context) {
    const double radius = 10;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: sms?.messageKind == SmsMessageKind.sent.name
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(5),
              constraints: BoxConstraints(maxWidth: mq(context).width * .8),
              // width: mq(context).width * .8,
              decoration: BoxDecoration(
                color: sms?.messageKind == SmsMessageKind.sent.name
                    ? AppColor.orangeColor
                    : AppColor.secondryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              child: Text(sms?.body ?? "")),
          // Text(
          //   sms?.dateSent?.formatRelativeDateTime() ?? "",
          //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          // ),
          Text(
            sms?.date ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
