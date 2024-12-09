import 'package:spam_delection_app/lib.dart';

class CallLogListItem extends StatelessWidget {
  final CallLogData callLog;

  const CallLogListItem({
    super.key,
    required this.callLog,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
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
        backgroundImage: AssetImage(callLog.isSpam == 1
            ? IconConstants.icFraud
            : IconConstants.icfluentCall),
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
            callLog.callTime?.formatDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          if (callLog.markSpamByUser != 0)
            Text(
              "${callLog.markSpamByUser} Spam reports",
              style: textTheme(context).bodyMedium?.copyWith(color: Colors.red),
            )
          else ...[
            Icon(getCallTypeIcon(callLog.callType),
                color: getCallTypeColor(callLog.callType)),
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
                  child: const Text("Report")),
              PopupMenuItem(
                  onTap: () {
                    markSpamBloc.add(BlockUnBlockEvent(
                        contactId: callLog.mobileNo ?? "", comments: "block"));
                  },
                  child: Text(callLog.isBlocked == 1 ? "Unblock" : "Block"))
            ],
          ),
        ],
      ),
      // trailing: Text(callLog.callTime?.formatDateTime() ?? ""),
    );
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

getCallLogType(String? callLogType) {
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
  }
}
