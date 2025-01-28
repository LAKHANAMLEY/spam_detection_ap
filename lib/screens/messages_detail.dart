import 'package:spam_delection_app/lib.dart';

final TextEditingController messageController = TextEditingController();
final messagesBloc = ApiBloc(ApiBlocInitialState());

class MessagesDetail extends StatelessWidget {
  final SmsLog? sms;

  const MessagesDetail({super.key, this.sms});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as MessagesDetail;
    var sms = arg.sms;
    return Scaffold(
        appBar: CustomAppBar(
            title: (sms?.name?.isNotEmpty ?? false)
                ? sms?.name ?? ""
                : sms?.countryCode?.isNotEmpty ?? false
                    ? "+${sms?.countryCode} ${sms?.address ?? ""}"
                    : sms?.address ?? "",
            actions: [
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
                        isScrollControlled: false,
                        backgroundColor: AppColor.secondaryColor,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        builder: (BuildContext context) {
                          return BlockSmsView(
                            sms: SmsDetail(
                              address: sms?.address,
                              //spamMessage: SmsDetail().spamMessage,
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
        bottomNavigationBar: messageField(context),
        body: ListView.builder(
          itemCount: sms?.smsDetails?.length,
          itemBuilder: (context, index) => MessageView(
            sms: sms?.smsDetails?[index],
          ),
        ));
  }

  send() {
    sendSms(sms?.address ?? "", messageController.text);
    messageController.clear();
  }

  messageField(context) => Container(
        height: 80,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CustomTextField(
            hintText: appLocalization(context).sendSms,
            controller: messageController,
            style: const TextStyle(color: AppColor.primaryColor),
            suffix: IconButton(
              onPressed: send,
              icon: const Icon(
                Icons.send,
                color: Colors.blueAccent,
              ),
            )),
      );
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
          Center(
            child: Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                constraints: BoxConstraints(maxWidth: mq(context).width * .8),
                // width: mq(context).width * .8,
                decoration: const BoxDecoration(
                  color: AppColor.greyColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text(sms?.date?.formatRelativeDay() ?? "")),
          ),
          Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(5),
              constraints: BoxConstraints(maxWidth: mq(context).width * .8),
              // width: mq(context).width * .8,
              decoration: BoxDecoration(
                color: sms?.messageKind == SmsMessageKind.sent.name
                    ? AppColor.orangeColor
                    : AppColor.secondaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              child: Text(sms?.body ?? "")),
          Text(
            //print(sms?.sendreceiveDatetime);

            sms?.date?.formatTime() ?? "",
            style: textTheme(context)
                .bodySmall
                ?.copyWith(color: AppColor.primaryColor),
          ),
        ],
      ),
    );
  }
}
