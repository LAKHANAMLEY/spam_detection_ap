import 'package:spam_delection_app/bloc/message_db_bloc/message_db_bloc.dart';
import 'package:spam_delection_app/bloc/message_db_bloc/message_db_event.dart';
import 'package:spam_delection_app/bloc/message_db_bloc/message_db_state.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/message/message_bubble_view.dart';
import 'package:spam_delection_app/screens/message/report_message_screen.dart';
import 'package:spam_delection_app/screens/message/unmark_spam_message_screen.dart';

final TextEditingController messageController = TextEditingController();

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
                    // PopupMenuItem(
                    //   onTap: () {
                    //     //Navigator.pushNamed(context, AppRoutes.callLogs,
                    //     //    arguments:
                    //     //     DeviceCallLogs(filterBy: CallType.outgoing.name));
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //         IconConstants.icSearchCheck,
                    //         color: AppColor.greyColor,
                    //         scale: 2,
                    //       ),
                    //       SizedBox(
                    //         width: MediaQuery.of(context).size.width * 5 / 100,
                    //       ),
                    //       Text(
                    //         appLocalization(context).searchInConversation,
                    //         style: const TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w600),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                            width: MediaQuery.of(context).size.width * 5 / 100,
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
                            width: MediaQuery.of(context).size.width * 5 / 100,
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
        bottomNavigationBar: messageField(context, sms),
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
                  itemCount: sms?.smsDetails?.length,
                  itemBuilder: (context, index) {
                    final previousMessageDate =
                        index > 0 ? sms?.smsDetails![index - 1].date : null;
                    final showDateHeader = (previousMessageDate == null ||
                        (!sms!.smsDetails![index].date!
                            .isSameDay(previousMessageDate)));
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
              );
            }));
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
                color: AppColor.themeOrangeColor,
              ),
            )),
      );
}
