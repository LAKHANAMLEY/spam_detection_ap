import 'package:phone_state/phone_state.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:spam_delection_app/lib.dart';

class CallLogListItem extends StatelessWidget {
  final CallLogData callLog;
  final bool showPopupMenuBtn;
  final void Function()? onTap;

  const CallLogListItem({
    super.key,
    required this.callLog,
    this.showPopupMenuBtn = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: onTap ??
          () {
            Navigator.pushNamed(context, AppRoutes.contactDetail,
                arguments: ContactDetail(
                  contact: ContactData(
                    countryCode: callLog.countryCode,
                    mobileNo: callLog.mobileNo,
                    name: callLog.name,
                    numberType: callLog.callType,
                    id: callLog.contactListId,
                    isSpam: callLog.isSpam,
                    isBlocked: callLog.isBlocked,
                    markspambyuser: callLog.markSpamByUser,
                  ),
                ));
          },
      leading: CircleAvatar(
        backgroundColor: AppColor.newGreyColor,
        // backgroundImage: AssetImage(
        //   getIcon(callLog),
        // ),
        child: Image.asset(
          getCallTypeImage(callLog),
          // fit: BoxFit.scaleDown,
        ),
      ),
      // leading: Icon(getCallTypeIcon(callLog.callType),
      //     color: getCallTypeColor(callLog.callType)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              (callLog.name?.isNotEmpty ?? false)
                  ? callLog.name ?? ""
                  : callLog.countryCode?.isNotEmpty ?? false
                      ? "+${callLog.countryCode} ${callLog.mobileNo ?? ""}"
                      : callLog.mobileNo ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).titleMedium,
            ),
          ),
          10.width(),
          Text(
            callLog.callTime?.formatRelativeDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
          //
        ],
      ),
      subtitle: Row(
        children: [
          if (callLog.markSpamByUser != null && callLog.markSpamByUser != 0)
            Text(
              "${callLog.markSpamByUser ?? 0} Spam reports",
              style: textTheme(context).bodyMedium?.copyWith(color: Colors.red),
            )
          else ...[
            Icon(
              getCallTypeIcon(callLog.callType),
              color: getCallTypeColor(callLog.callType),
              size: 15,
            ),
            5.width(),
            Text(
              callLog.callType ?? "",
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: getCallTypeColor(callLog.callType)),
            ),
          ],
          const Circle(),
          // 2.width(),
          Text(callLog.callDuration?.convertInMinSec() ?? ""),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text(
          //   callLog.callTime?.formatDateTime() ?? "",
          //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          // ),
          if (showPopupMenuBtn)
            PopupMenuButton(
              menuPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              // position: ,
              itemBuilder: (context) => [
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
                          return ReportView(
                            contact: ContactData(
                              id: callLog.contactListId,
                              mobileNo: callLog.mobileNo,
                              name: callLog.name,
                              isSpam: callLog.isSpam,
                              countryCode: callLog.countryCode,
                            ),
                          );
                        },
                      );
                    },
                    child: Text(appLocalization(context).reportText)),
                PopupMenuItem(
                    onTap: () {
                      markSpamBloc.add(BlockUnBlockEvent(
                          contactId: callLog.mobileNo ?? "",
                          comments: appLocalization(context).block));
                    },
                    child: Text(callLog.isBlocked == 1
                        ? appLocalization(context).unblock
                        : appLocalization(context).block)),
                PopupMenuItem(
                    onTap: () {
                      // deleteDeviceCallLog(
                      //    id: contact?.id ?? "",
                      //   number: contact?.mobileNo ?? "");
                      callLogsListBloc.add(DeleteCallLogEvent(
                          callLog: CallLogData(id: callLog.id)));
                    },
                    child: Text(appLocalization(context).deleteCallLogs))
              ],
            ),
        ],
      ),
      // trailing: Text(callLog.callTime?.formatDateTime() ?? ""),
    );
  }
}

String getCallTypeImage(CallLogData callLog) {
  var callType = getCallLogType(callLog.callType);
  if (callLog.isSpam == 1) {
    return IconConstants.icFraud;
  } else {
    switch (callType) {
      case null:
        return IconConstants.icCallRegular;
      case CallType.incoming:
        return IconConstants.icIncoming;
      case CallType.outgoing:
        return IconConstants.icOutgoing;
      case CallType.missed:
        return IconConstants.icMissCall;
      case CallType.voiceMail:
        return IconConstants.icFluentMail;
      case CallType.rejected:
        return IconConstants.icMissCall;
      case CallType.blocked:
        return IconConstants.icBlockCall;
      case CallType.answeredExternally:
        return IconConstants.icCallRegular;
      case CallType.unknown:
        return IconConstants.icCallRegular;
      case CallType.wifiIncoming:
        return IconConstants.icIncoming;
      case CallType.wifiOutgoing:
        return IconConstants.icOutgoing;
    }
  }
}

Color getCallTypeColor(String? callLogType) {
  var callType = getCallLogType(callLogType);
  switch (callType) {
    case CallType.incoming:
      return Colors.grey;
    case CallType.outgoing:
      return Colors.grey;
    case CallType.missed:
      return Colors.red;
    case CallType.voiceMail:
      return Colors.grey;
    case CallType.rejected:
      return Colors.red;
    case CallType.blocked:
      return Colors.red;
    case CallType.answeredExternally:
      return Colors.grey;
    case CallType.unknown:
      return Colors.grey;
    case CallType.wifiIncoming:
      return Colors.grey;
    case CallType.wifiOutgoing:
      return Colors.grey;
    case null:
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

IconData getCallTypeIcon(String? callLogType) {
  var callType = getCallLogType(callLogType);
  switch (callType) {
    case CallType.incoming:
      return Icons.call_received;
    case CallType.outgoing:
      return Icons.call_made;
    case CallType.missed:
      return Icons.call_missed;
    case CallType.voiceMail:
      return Icons.voicemail_sharp;
    case CallType.rejected:
      return Icons.call_end;
    case CallType.blocked:
      return Icons.block;
    case CallType.answeredExternally:
      return Icons.call_received;
    case CallType.unknown:
      return Icons.device_unknown;
    case CallType.wifiIncoming:
      return Icons.wifi_calling;
    case CallType.wifiOutgoing:
      return Icons.wifi_calling_3;
    case null:
      return Icons.call_received;
    default:
      return Icons.call_received;
  }
}

CallType? getCallLogType(String? callLogType) {
  switch (callLogType) {
    case null:
      return null;
    case "incoming":
      return CallType.incoming;
    case "outgoing":
      return CallType.outgoing;
    case "missed":
      return CallType.missed;
    case "voiceMail":
      return CallType.voiceMail;
    case "rejected":
      return CallType.rejected;
    case "blocked":
      return CallType.blocked;
    case "answeredExternally":
      return CallType.answeredExternally;
    case "unknown":
      return CallType.unknown;
    case "wifiIncoming":
      return CallType.wifiIncoming;
    case "wifiOutgoing":
      return CallType.wifiOutgoing;
//Phone state background cases
    case "incomingstart":
      return CallType.incoming;
    case "incomingmissed":
      return CallType.missed;
    case "incomingreceived":
      return CallType.incoming;
    case "incomingend":
      return CallType.incoming;
    case "outgoingend":
      return CallType.outgoing;
    case "outgoingstart":
      return CallType.outgoing;

    case "NOTHING":
      return CallType.unknown;
    case "CALL_INCOMING":
      return CallType.incoming;
    case "CALL_STARTED":
      return CallType.incoming;
    case "CALL_ENDED":
      return CallType.rejected;
    default:
      return null;
  }
}

String getCallTypeStringFromBGPhoneState(PhoneStateBackgroundEvent phoneState) {
  switch (phoneState) {
    case PhoneStateBackgroundEvent.incomingstart:
      return "Incoming call";
    case PhoneStateBackgroundEvent.incomingmissed:
      return "Missed call";
    case PhoneStateBackgroundEvent.incomingreceived:
      return "Ongoing call";
    case PhoneStateBackgroundEvent.incomingend:
      return "Call end";
    case PhoneStateBackgroundEvent.outgoingend:
      return "Call end";
    case PhoneStateBackgroundEvent.outgoingstart:
      return "Ongoing call";
    default:
      return "Unknown";
  }
}

String getCallTypeByPhoneState(PhoneState phoneState) {
  switch (phoneState.status) {
    case PhoneStateStatus.NOTHING:
      return "Unknown";
    case PhoneStateStatus.CALL_INCOMING:
      return "Incoming call";
    case PhoneStateStatus.CALL_STARTED:
      return "Ongoing call";
    case PhoneStateStatus.CALL_ENDED:
      return "Call end";
    default:
      return "Unknown";
  }
}
