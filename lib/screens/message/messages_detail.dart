import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

final TextEditingController messageController = TextEditingController();

class MessagesDetail extends StatefulWidget {
  final SmsLog? sms;

  const MessagesDetail({super.key, this.sms});

  @override
  State<MessagesDetail> createState() => _MessagesDetailState();
}

class _MessagesDetailState extends State<MessagesDetail> {
  SmsLog? sms;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((s) {
      var arg = args(context) as MessagesDetail;
      sms = arg.sms!;
      if (sms?.smsDetails?.isNotEmpty ?? false) {
        context
            .read<MessageDBBloc>()
            .add(SyncMessageDetailsWithServer(smsLogs: sms!));
      }
      if (sms?.unreadReceivedSms == 1) {
        context
            .read<MessageDBBloc>()
            .add(ReadDBMessage(sms: sms!.copyWith(unreadReceivedSms: 0)));
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageDBBloc, MessageDBState>(
        listener: (context, state) {
      if (state is MessageDBDeletedAllConversation) {
        sms?.smsDetails?.clear();
      }
      if (state is MessageDBLoaded) {
        sms = state.smsLogs.firstWhere((e) => e.address == sms?.address);
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: CustomAppBar(
              title: (sms?.name?.isNotEmpty ?? false)
                  ? sms?.name ?? ""
                  : sms?.address ?? "",
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
                              width:
                                  MediaQuery.of(context).size.width * 5 / 100,
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
                          context
                              .read<MessageDBBloc>()
                              .add(DeleteAllSmsLogs(smsLog: sms!));
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              IconConstants.icDelete,
                              color: AppColor.redColor,
                              scale: 1,
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 5 / 100,
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
                      if (sms?.isMarkSpam != 1)
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
                                    address: sms?.address,
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
                      if (sms?.isMarkSpam == 1)
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
                                      address: sms?.address,
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
          bottomNavigationBar: (sms?.address?.isNumber ?? false)
              ? messageField(context, sms)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     OutlinedButton.icon(
                    //         onPressed: () {
                    //           showModalBottomSheet(
                    //             showDragHandle: true,
                    //             useSafeArea: true,
                    //             isScrollControlled: true,
                    //             backgroundColor: AppColor.whiteColor,
                    //             context: context,
                    //             shape: const RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.vertical(
                    //                   top: Radius.circular(20.0)),
                    //             ),
                    //             builder: (BuildContext context) {
                    //               return BlockSmsView(
                    //                 sms: SmsDetail(
                    //                   address: sms?.address,
                    //                   //spamMessage: SmsDetail().spamMessage,
                    //                 ),
                    //               );
                    //             },
                    //           );
                    //         },
                    //         icon: Icon(
                    //           Icons.report,
                    //           color: Colors.red,
                    //         ),
                    //         label: Text(appLocalization(context).reportText)),
                    //     OutlinedButton.icon(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.block,
                    //           color: Colors.red,
                    //         ),
                    //         label: Text(appLocalization(context).block))
                    //   ],
                    // ),
                    Text(
                      appLocalization(context)
                          .replyingIsNotSupportedByThisSender,
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: (sms?.smsDetails?.length ?? 0),
                          itemBuilder: (context, index) {
                            // int index = (sms?.smsDetails?.length ?? 0) - i - 1;//reverse
                            final currentMessage = sms?.smsDetails![index];
                            // Since list is reversed, the "previous" message visually is the one with the next index
                            final isLastMessage =
                                index == sms!.smsDetails!.length - 1;
                            final nextMessageDate = !isLastMessage
                                ? sms?.smsDetails![index + 1].date
                                : null;
                            final showDateHeader = (nextMessageDate == null ||
                                !currentMessage!.date!
                                    .isSameDay(nextMessageDate));

                            return Column(
                              children: [
                                if (showDateHeader)
                                  Text(sms?.smsDetails?[index].date
                                          ?.formatRelativeDay() ??
                                      ""),
                                MessageView(
                                  sms: sms?.smsDetails?[index],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      if (!(sms?.address?.isNumber ?? true) ||
                          (sms?.name?.isEmpty ?? true))
                        Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                  onPressed: () {
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
                                            address: sms?.address,
                                            //spamMessage: SmsDetail().spamMessage,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.report,
                                    color: Colors.red,
                                  ),
                                  label: Text(
                                      appLocalization(context).reportText)),
                              10.width(),
                              OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  ),
                                  label: Text(appLocalization(context).block))
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }));
    });
  }

  Future<void> send(SmsLog? sms, BuildContext context) async {
    var smsMessage = SmsMessage(
      sms?.address,
      messageController.text,
      date: DateTime.now(),
      kind: SmsMessageKind.Sent,
      read: false,
    );
    await SMSController.sendSmsByDevice(smsMessage).onError(handleError);
    await Future.delayed(Duration(seconds: 1));
    var messages =
        await SMSController.getDeviceSms(address: sms?.address, count: 1);
    log("Message sent: ${messages.first.toMap}");
    // context
    //     .read<MessageDBBloc>()
    //     .add(SyncChangedMessageWithServer(smsMessage: messages.first));
    context
        .read<MessageDBBloc>()
        .add(SyncMessageDetailsWithServer(smsLogs: sms!));
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
            fillColor: Colors.white,
            hintText: appLocalization(context).enterMessage,
            controller: messageController,
            suffix: InkWell(
              onTap: () {
                send(sms, context);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.themeOrangeColor),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  // color: AppColor.themeOrangeColor,
                ),
              ),
            )),
      );
}
