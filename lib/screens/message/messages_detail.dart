import 'package:spam_delection_app/lib.dart';

final TextEditingController messageController = TextEditingController();

class MessagesDetail extends StatefulWidget {
  final SmsLog? sms;

  const MessagesDetail({super.key, this.sms});

  @override
  State<MessagesDetail> createState() => _MessagesDetailState();
}

class _MessagesDetailState extends State<MessagesDetail> {
  late final AppLifecycleListener _appLifecycleListener;

  handleAppLifeCycle() {
    _appLifecycleListener = AppLifecycleListener(
      onResume: () {
        context
            .read<MessageDBBloc>()
            .add(SyncMessageDetailsWithServer(smsLogs: sms!));
      },
      // onInactive: () {},
    );
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  SmsLog? sms;

  List<SmsDetail> smsDetails = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((s) {
      var arg = args(context) as MessagesDetail;
      sms = arg.sms!;
      smsDetails = sms?.smsDetails ?? [];
      if (sms?.threadId?.isNotEmpty ?? false) {
        context
            .read<MessageDBBloc>()
            .add(ImportAllDeviceMessagesDetails(threadId: sms?.threadId ?? ""));
        context
            .read<MessageDBBloc>()
            .add(SyncMessageDetailsWithServer(smsLogs: sms!));
      }
      if ((sms?.unreadReceivedSms ?? 0) > 0) {
        context
            .read<MessageDBBloc>()
            .add(ReadDBMessage(sms: sms!.copyWith(unreadReceivedSms: 0)));
      }
      setState(() {});
    });
    handleAppLifeCycle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SmsBloc, SmsState>(
      listener: (context, state) async {
        // if (state is NewSmsReceived) {
        //   context
        //       .read<MessageDBBloc>()
        //       .add(SyncChangedMessageWithServer(smsMessage: state.message));
        //   // context.read<MessageDBBloc>().add(AddSmsLog(
        //   //     SmsLog.fromSmsMessage(state.message, ContactData(), null)));
        //   // context.read<MessageDBBloc>().add(
        //   //       SyncChangedMessageWithServer(smsMessage: state.message),
        //   //     );
        // } else if (state is NewSmsSent) {
        //   context
        //       .read<MessageDBBloc>()
        //       .add(SyncChangedMessageWithServer(smsMessage: state.message));
        //   // context.read<MessageDBBloc>().add(AddSmsLog(
        //   //     SmsLog.fromSmsMessage(state.message, ContactData(), null)));
        //   // context
        //   //     .read<MessageDBBloc>()
        //   //     .add(GetAllSmsFromDB(start: startFrom, limit: limit));
        //   // context.read<MessageDBBloc>().add(
        //   //       SyncChangedMessageWithServer(smsMessage: state.message),
        //   //     );
        // }
        // if (state is SmsInitial) {
        //   log("Initial state");
        //   context.read<SmsBloc>().add(StartListeningSms());
        // }
        // if (state is NewSmsReceived) {
        //   log("SMS received");
        //   // messagesBloc.add(GetDeviceMessagesEvent());
        //   context
        //       .read<MessageDBBloc>()
        //       .add(SyncChangedMessageWithServer(smsMessage: state.message));

        //   // var newMessage = await SMSController.getLastSms(state.message);
        //   // context.read<MessageDBBloc>().add(SyncMessageDetailsWithServer(
        //   //     smsLogs:
        //   //         SmsLog.fromSmsMessage(newMessage!, ContactData(), null)));
        //   // context.read<MessageDBBloc>().add(SyncMessagesWithServer());
        // }
        // if (state is NewSmsSent) {
        //   log("SMS delivered");
        //   // messagesBloc.add(GetDeviceMessagesEvent());
        //   // var newMessage = await SMSController.getLastSms(state.message);

        //   // context.read<MessageDBBloc>().add(SyncMessageDetailsWithServer(
        //   //     smsLogs:
        //   //         SmsLog.fromSmsMessage(newMessage!, ContactData(), null)));
        //   context
        //       .read<MessageDBBloc>()
        //       .add(SyncChangedMessageWithServer(smsMessage: state.message));
        //   // context.read<MessageDBBloc>().add(SyncMessagesWithServer());
        // }
      },
      child: BlocConsumer<MessageDBBloc, MessageDBState>(
          listener: (context, state) {
        if (state is MessageDetailsLoaded) {
          smsDetails = state.smsDetails;
        }
        if (state is MessageDBDeletedAllConversation) {
          sms?.smsDetails?.clear();
        }
        if (state is NewMessageReceived) {
          // sms = state.smsLogs.firstWhere((e) => e.address == sms?.address);
          // // log(state.smsLogs.first.body ?? "");
          // // log(state.smsLogs.last.body ?? "");
          // log(sms?.smsDetails?.first.body ?? "");
          context.read<MessageDBBloc>().add(
              GetSmsDetails(id: sms?.address ?? "", start: 0, limit: 1000));
        }
        if (state is MessageDBSynced) {
          sms =
              state.syncedSmsLogs.firstWhere((e) => e.address == sms?.address);
          context.read<MessageDBBloc>().add(
              GetSmsDetails(id: sms?.address ?? "", start: 0, limit: 1000));

          // sms =
          //     state.syncedSmsLogs.firstWhere((e) => e.address == sms?.address);
          // log(state.smsLogs.first.body ?? "");
          // log(state.smsLogs.last.body ?? "");
          // log(sms?.smsDetails?.first.body ?? "");
          // sms =
          //     state.syncedSmsLogs.firstWhere((e) => e.address == sms?.address);
          // log(state.smsLogs.first.body ?? "");
          // log(state.smsLogs.last.body ?? "");
          // // log(sms?.smsDetails?.first.body ?? "");
        }
      }, builder: (context, state) {
        return Scaffold(
            appBar: CustomAppBar(
                titleWidget: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.contactDetail,
                        arguments: ContactDetail(
                          contact: ContactData(
                            name: sms?.name,
                            mobileNo: sms?.address,
                          ),
                        ));
                  },
                  child: Row(
                    children: [
                      if (sms?.isSpam == "1")
                        Image.asset(
                          IconConstants.icSpamCircle,
                          height: 30,
                        ),
                      10.width(),
                      Text(
                        (sms?.name?.isNotEmpty ?? false)
                            ? sms?.name ?? ""
                            : sms?.address ?? "",
                        style: textTheme(context).titleMedium,
                      ),
                    ],
                  ),
                ),
                // title: (sms?.name?.isNotEmpty ?? false)
                //     ? sms?.name ?? ""
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
                          onTap: onBlockPressed,
                          child: Row(
                            children: [
                              // Image.asset(
                              //   IconConstants.icBlockedCall,
                              //   scale: 2.5,
                              // ),
                              Icon(
                                Icons.block,
                                color: Colors.red,
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
                        if (sms?.isMarkSpam != 1)
                          PopupMenuItem(
                            onTap: onReportPressed,
                            child: Row(
                              children: [
                                // Image.asset(
                                //   IconConstants.icReport,
                                //   color: AppColor.redColor,
                                //   scale: 4,
                                // ),
                                Icon(
                                  Icons.report,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
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
                            onTap: unMarkSpamPressed,
                            child: Row(
                              children: [
                                // Image.asset(
                                //   IconConstants.icReport,
                                //   color: AppColor.redColor,
                                //   scale: 3,
                                // ),
                                Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(
                                  appLocalization(context).unmarkSpam,
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
                                .add(DeleteAllSmsDetails(smsLog: sms!));
                          },
                          child: Row(
                            children: [
                              // Image.asset(
                              //   IconConstants.icDelete,
                              //   color: AppColor.redColor,
                              //   scale: 1,
                              // ),
                              Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red,
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
                      ],
                    );
                  }),
                ]),
            bottomNavigationBar: (sms?.address?.isNumber ?? false)
                ? messageField(context, sms)
                : replyingNotSupportedView(),
            body: BlocConsumer<MessageDBBloc, MessageDBState>(
              // bloc: markSpamSmsBloc,
              listener: (context, state) {
                if (state is MarkedSpamMessage) {
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
                  // context.read<MessageDBBloc>().add(SyncMessagesWithServer());
                  context
                      .read<MessageDBBloc>()
                      .add(SyncMessageDetailsWithServer(smsLogs: sms!));
                }
                if (state is UnMarkedSpamMessage) {
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
                  // context.read<MessageDBBloc>().add(SyncMessagesWithServer());
                  context
                      .read<MessageDBBloc>()
                      .add(SyncMessageDetailsWithServer(smsLogs: sms!));
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: Loader(),
                  inAsyncCall: state is MessageDBLoading,
                  child: Column(
                    children: [
                      messagesListView(),
                      if (!(sms?.address?.isNumber ?? true) ||
                          (sms?.name?.isEmpty ?? true) ||
                          sms?.isMarkSpam == 1)
                        bottomView(),
                    ],
                  ),
                );
              },
            ));
      }),
    );
  }

  send(SmsLog? sms, BuildContext context) async {
    var smsMessage = SmsMessage(
      sms?.address,
      messageController.text,
      date: DateTime.now(),
      kind: SmsMessageKind.Sent,
      read: false,
      threadId: int.tryParse(sms?.smsDetails?.firstOrNull?.threadId ?? ''),
    );
    var message =
        await SMSController.sendSmsByDevice(smsMessage).onError(handleError);
    // await Future.delayed(Duration(seconds: 1));
    // await SMSController.getLastSms(smsMessage);
    context.read<MessageDBBloc>().add(AddSmsLog(message!));
    // context
    //     .read<MessageDBBloc>()
    //     .add(SyncChangedMessageWithServer(smsMessage: message!));

    // context
    //     .read<MessageDBBloc>()
    //     .add(SyncMessageDetailsWithServer(smsLogs: sms!));
    messageController.clear();
  }

  FutureOr<SmsMessage?> handleError(Object error, StackTrace stackTrace) {
    showToast(error.toString());
    return null;
  }

  Widget messageField(context, SmsLog? sms) => Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(5),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextField(
                fillColor: Colors.white,
                hintText: appLocalization(context).enterMessage,
                controller: messageController,
                borderRadius: BorderRadius.circular(50),
                // suffix: InkWell(
                //   onTap: () {
                //     send(sms, context);
                //   },
                //   child: Container(
                //     padding: EdgeInsets.all(8),
                //     decoration: BoxDecoration(
                //         shape: BoxShape.circle, color: AppColor.themeOrangeColor),
                //     child: const Icon(
                //       Icons.send,
                //       color: Colors.white,
                //       // color: AppColor.themeOrangeColor,
                //     ),
                //   ),
                // ),
              ),
            ),
            InkWell(
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
            ),
          ],
        ),
      );

  void onReportPressed() {
    showModalBottomSheet(
      constraints: BoxConstraints.tight(Size(double.infinity, 550)),
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return ReportSmsView(
          sms: sms!.smsDetails!.first,
        );
      },
    );
  }

  void onBlockPressed() {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      // isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return BlockSmsView(
          sms: sms!.smsDetails!.first,
        );
      },
    );
  }

  void unMarkSpamPressed() {
    showModalBottomSheet(
      // showDragHandle: true,
      // useSafeArea: true,
      // isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 20 / 100),
          child: UnMarkSmsView(
            sms: sms!.smsDetails!.first,
          ),
        );
      },
    );
  }

  Widget replyingNotSupportedView() => Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalization(context).replyingIsNotSupportedByThisSender,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget bottomView() => Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (sms?.isMarkSpam != 1)
              OutlinedButton.icon(
                  onPressed: onReportPressed,
                  icon: Icon(
                    Icons.report,
                    color: Colors.red,
                  ),
                  label: Text(appLocalization(context).reportText)),
            if (sms?.isMarkSpam == 1)
              OutlinedButton.icon(
                  onPressed: unMarkSpamPressed,
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  label: Text(appLocalization(context).unmarkSpam)),
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
      );

  Widget messagesListView() => Expanded(
        child: ListView.builder(
          reverse: true,
          itemCount: smsDetails.length,
          itemBuilder: (context, index) {
            // int index = (sms?.smsDetails?.length ?? 0) - i - 1;//reverse
            final currentMessage = smsDetails[index];
            // Since list is reversed, the "previous" message visually is the one with the next index
            final isLastMessage = index == smsDetails.length - 1;
            final nextMessageDate =
                !isLastMessage ? smsDetails[index + 1].date : null;
            final showDateHeader = (nextMessageDate == null ||
                !currentMessage.date!.isSameDay(nextMessageDate));

            return Column(
              children: [
                if (showDateHeader)
                  Text(smsDetails[index].date?.formatRelativeDay() ?? ""),
                MessageView(
                  sms: smsDetails[index],
                ),
              ],
            );
          },
        ),
      );
}
