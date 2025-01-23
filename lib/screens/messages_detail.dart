import 'package:spam_delection_app/extensions/date_time_day_ext.dart';
import 'package:spam_delection_app/lib.dart';

import 'blocked_sms_screen.dart';

final TextEditingController messageController = TextEditingController();

class MessagesDetail extends StatelessWidget {
  // Future<void> sendSMS(String phoneNumber, String message) async {
  //   final Uri smsUri = Uri(
  //     scheme: 'sms',
  //     path: phoneNumber,
  //     queryParameters: {'body': message}, // Message content
  //   );
  //
  //   if (await canLaunchUrl(smsUri)) {
  //     await launchUrl(smsUri);
  //   } else {
  //     throw 'Could not launch SMS';
  //   }
  // }
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
                      //messagesBloc.add(DeleteConversationEvent(address: ''));
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
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: sms?.smsDetails?.length,
              itemBuilder: (context, index) => MessageView(
                sms: sms?.smsDetails?[index],
              ),
            ),
          ),
          CustomTextField(
              hintText: appLocalization(context).sendSms,
              controller: messageController,
              style: const TextStyle(color: AppColor.primaryColor),
              suffix: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.blueAccent,
                ),
              )),
        ]));
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
          Center(
            child: Container(
                margin: const EdgeInsets.all(2),
                // padding: const EdgeInsets.all(5),
                constraints: BoxConstraints(maxWidth: mq(context).width * .8),
                // width: mq(context).width * .8,
                decoration: const BoxDecoration(
                  color: AppColor.greyColor,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Text(
                    sms?.sendreceiveDatetime?.formatRelativeDateDay() ?? "")),
          ),

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
          Text(
            //print(sms?.sendreceiveDatetime);
            // sms?.date?.formatRelativeDateTime() ?? "",
            // style: textTheme(context).bodySmall?.copyWith(color: AppColor.primaryColor),
            // ),

            sms?.sendreceiveDatetime?.formatRelativeDateDay() ?? "",
            style: textTheme(context)
                .bodySmall
                ?.copyWith(color: AppColor.primaryColor),
          ),
          /*Text(
            //print(sms?.sendreceiveDatetime);
            // sms?.date?.formatRelativeDateTime() ?? "",
            // style: textTheme(context).bodySmall?.copyWith(color: AppColor.primaryColor),
            // ),

            sms?.messageKind ?? "",
            style: textTheme(context)
                .bodySmall
                ?.copyWith(color: AppColor.primaryColor),
          ),

           */

          /*Text(
            sms?.sendreceiveDatetime?.formatRelativeDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),

           */
          /*Text(
            sms?.messageKind ?? "",
            style: textTheme(context)
                .bodySmall
                ?.copyWith(color: AppColor.primaryColor),
          ),

           */
          //print(sms?.sendreceiveDatetime);
        ],
      ),
    );
  }

// Future<void> sendSMS(String phoneNumber, String message) async {
//   final Uri smsUri = Uri(
//     scheme: 'sms',
//     path: phoneNumber,
//     queryParameters: {'body': message}, // Message content
//   );
//
//   if (await canLaunchUrl(smsUri)) {
//     await launchUrl(smsUri);
//   } else {
//     throw 'Could not launch SMS';
//   }
// }
}

//extension on String? {
//  formatRelativeDateTime() {}
//}
// extension DateTimeExt on DateTime {
//   String formatDateTime() =>
//       DateFormat('dd MMM yyyy hh:mm a', 'en').format(this);
//
//   String formatDate() => DateFormat('dd MMM yyyy').format(this);
//
//   String formatTime() => DateFormat('hh:mm a').format(this);
//
//   String formatRelativeDateTime() => isToday
//       ? "Today @ ${formatTime()}"
//       : isYesterday
//           ? "Yesterday @ ${formatTime()}"
//           : formatDateTime();
//
//   bool get isToday {
//     final now = DateTime.now();
//     return now.day == day && now.month == month && now.year == year;
//   }
//
//   bool get isYesterday {
//     final yesterday = DateTime.now().subtract(const Duration(days: 1));
//     return yesterday.day == day &&
//         yesterday.month == month &&
//         yesterday.year == year;
//   }
// }
