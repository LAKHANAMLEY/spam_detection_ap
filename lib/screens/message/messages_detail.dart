import 'package:spam_delection_app/lib.dart';

final TextEditingController messageController = TextEditingController();

class MessagesDetail extends StatelessWidget {
  final SmsLog? sms;

  const MessagesDetail({super.key, this.sms});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as MessagesDetail;
    var sms = arg.sms!;
    if (sms.unreadReceivedSms == 1) {
      context
          .read<MessageDBBloc>()
          .add(ReadDBMessage(sms: sms.copyWith(unreadReceivedSms: 0)));
    }
    return Scaffold(
        appBar: CustomAppBar(
            title: (sms.name?.isNotEmpty ?? false)
                ? sms.name ?? ""
                : sms.address ?? "",
            // : sms?.countryCode?.isNotEmpty ?? false
            //     ? "+${sms?.countryCode} ${sms?.address ?? ""}"
            //     : sms?.address ?? "",
            actions: [
              BlocBuilder<MessageDBBloc, MessageDBState>(
                  // bloc: messagesBloc,
                  builder: (context, state) {
                // if (state is DeletedDBSmsLog) {
                //   if (state.value.statusCode == 200) {
                //     showCustomDialog(context,
                //         dialogType: DialogType.success,
                //         subTitle: state.value.message ?? "");
                //   } else if (state.value.statusCode ==
                //       HTTPStatusCodes.sessionExpired) {
                //     sessionExpired(context, state.value.message ?? "");
                //   } else {
                //     showToast(state.value.message);
                //   }
                //   messagesBloc.add(SmsListEvent());
                // }
                return PopupMenuButton(
                  color: AppColor.lightOrange,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          useSafeArea: true,
                          isScrollControlled: true,
                          backgroundColor: AppColor.whiteColor,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          ),
                          builder: (BuildContext context) {
                            return BlockSmsView(
                              sms: SmsDetail(
                                address: sms.address,
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
                                color: AppColor.blackColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        // messagesBloc.add(DeleteConversationEvent());
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
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    if (sms.isMarkSpam != 1)
                      PopupMenuItem(
                        onTap: () {
                          showModalBottomSheet(
                            // showDragHandle: true,
                            // useSafeArea: true,
                            // isScrollControlled: true,
                            backgroundColor: AppColor.whiteColor,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0)),
                            ),
                            builder: (BuildContext context) {
                              return ReportSmsView(
                                sms: SmsDetail(
                                  address: sms.address,
                                  //spamMessage: SmsDetail().spamMessage,
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              IconConstants.icReport,
                              color: AppColor.redColor,
                              scale: 3,
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 5 / 100,
                            ),
                            Text(
                              appLocalization(context).reportText,
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    if (sms.isMarkSpam == 1)
                      PopupMenuItem(
                        onTap: () {
                          showModalBottomSheet(
                            // showDragHandle: true,
                            // useSafeArea: true,
                            // isScrollControlled: true,
                            backgroundColor: AppColor.whiteColor,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0)),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                constraints: BoxConstraints(
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            20 /
                                            100),
                                child: UnMarkSmsView(
                                  sms: SmsDetail(
                                    address: sms.address,
                                    //spamMessage: SmsDetail().spamMessage,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              IconConstants.icReport,
                              color: AppColor.redColor,
                              scale: 3,
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 5 / 100,
                            ),
                            Text(
                              appLocalization(context).unMarkSMs,
                              style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ]),
        bottomNavigationBar: sms.address?.isNumber ?? false
            ? messageField(context, sms)
            : Text(
                appLocalization(context).replyingIsNotSupportedByThisSender,
                textAlign: TextAlign.center,
              ),
        body: BlocConsumer(
            bloc: markSpamSmsBloc,
            listener: (context, state) {
              if (state is MarkSpamSmsState) {
                if (state.value.statusCode == 200) {
                  showCustomDialog(context,
                      dialogType: DialogType.success,
                      subTitle: state.value.message);
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message);
                } else {
                  showCustomDialog(context,
                      dialogType: DialogType.failed,
                      subTitle: state.value.message);
                }
                // messagesBloc.add(SmsListEvent());
                context.read<MessageDBBloc>().add(SyncMessagesWithServer());
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: Loader(),
                inAsyncCall: state is ApiLoadingState,
                child: ListView.builder(
                  reverse: true,
                  itemCount: (sms.smsDetails?.length ?? 0),
                  itemBuilder: (context, index) {
                    // int index = (sms?.smsDetails?.length ?? 0) - i - 1;//reverse
                    final currentMessage = sms.smsDetails![index];
                    // Since list is reversed, the "previous" message visually is the one with the next index
                    final isLastMessage = index == sms.smsDetails!.length - 1;
                    final nextMessageDate =
                        !isLastMessage ? sms.smsDetails![index + 1].date : null;
                    final showDateHeader = (nextMessageDate == null ||
                        !currentMessage.date!.isSameDay(nextMessageDate));

                    return Column(
                      children: [
                        if (showDateHeader)
                          Text(sms.smsDetails?[index].date
                                  ?.formatRelativeDay() ??
                              ""),
                        MessageView(
                          sms: sms.smsDetails?[index],
                        ),
                      ],
                    );
                  },
                ),
              );
            }));
  }

  void send(SmsLog? sms, BuildContext context) {
    var smsMessage = SmsMessage(
      sms?.address,
      messageController.text,
    );
    sendSmsByDevice(smsMessage).onError(handleError);
    context
        .read<MessageDBBloc>()
        .add(SyncChangedMessageWithServer(smsMessage: smsMessage));
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
                send(sms, context);
              },
              icon: const Icon(
                Icons.send,
                color: AppColor.themeOrangeColor,
              ),
            )),
      );
}
