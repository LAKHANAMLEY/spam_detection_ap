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
                : sms?.address ?? "",
            // : sms?.countryCode?.isNotEmpty ?? false
            //     ? "+${sms?.countryCode} ${sms?.address ?? ""}"
            //     : sms?.address ?? "",
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
        bottomNavigationBar: messageField(context, sms),
        body: ListView.builder(
          itemCount: sms?.smsDetails?.length,
          itemBuilder: (context, index) => MessageView(
            sms: sms?.smsDetails?[index],
          ),
        ));
  }

  send(SmsLog? sms) {
    sendSms(sms?.address ?? "", messageController.text).onError(handleError);
    messageController.clear();
  }

  FutureOr<SmsMessage?> handleError(Object error, StackTrace stackTrace) {
    showToast(error.toString());
    return null;
  }

  messageField(context, SmsLog? sms) => Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CustomTextField(
            hintText: appLocalization(context).enterMessage,
            controller: messageController,
            suffix: IconButton(
              onPressed: () {
                send(sms);
              },
              icon: const Icon(
                Icons.send,
                color: AppColor.orangeColor,
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
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              constraints: BoxConstraints(maxWidth: mq(context).width * .8),
              // width: mq(context).width * .8,
              decoration: const BoxDecoration(
                color: AppColor.greyColor,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Text(
                sms?.date?.formatRelativeDay() ?? "",
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              )),
        ),
        // 5.height(),
        Align(
          alignment: sms?.messageKind == SmsMessageKind.Sent.name
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            constraints: BoxConstraints(maxWidth: mq(context).width * .8),
            child: Column(
              crossAxisAlignment: sms?.messageKind == SmsMessageKind.Sent.name
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(5),
                    // constraints:
                    //     BoxConstraints(maxWidth: mq(context).width * .8),
                    // width: mq(context).width * .8,
                    decoration: BoxDecoration(
                      color: sms?.messageKind == SmsMessageKind.Sent.name
                          ? AppColor.orangeColor
                          : AppColor.secondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(radius),
                        bottomRight: const Radius.circular(radius),
                        topLeft: (sms?.messageKind == SmsMessageKind.Sent.name)
                            ? const Radius.circular(radius)
                            : const Radius.circular(0),
                        topRight: (sms?.messageKind == SmsMessageKind.Sent.name)
                            ? const Radius.circular(0)
                            : const Radius.circular(radius),
                      ),
                    ),
                    child: Text(sms?.body ?? "")),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    //print(sms?.sendreceiveDatetime);

                    sms?.date?.formatTime() ?? "",
                    style: textTheme(context)
                        .bodySmall
                        ?.copyWith(color: AppColor.greyColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
