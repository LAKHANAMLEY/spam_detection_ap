import 'package:spam_delection_app/lib.dart';

class DeviceCallLogs extends StatefulWidget {
  final bool? showAppBar;
  final String filterBy;
  const DeviceCallLogs({super.key, this.showAppBar = true, this.filterBy = ""});

  @override
  State<DeviceCallLogs> createState() => _DeviceCallLogsState();
}

class _DeviceCallLogsState extends State<DeviceCallLogs> {
  List<CallLogData> callLogs = [];
  List<CallLogData> filteredCallLogs = [];

  var searchController = TextEditingController();

  StreamSubscription<ApiState>? streamSubs;

  @override
  void initState() {
    super.initState();
    callLogsListBloc.add(GetDeviceCallLogEvent());
  }

  filter() {
    var argument = args(context) as DeviceCallLogs?;
    filteredCallLogs = callLogs
        .where((e) =>
            ((e.name
                        ?.toLowerCase()
                        .contains(searchController.text.toLowerCase()) ??
                    false) ||
                (e.mobileNo
                        ?.toLowerCase()
                        .contains(searchController.text.toLowerCase()) ??
                    false)) &&
            (e.callType
                    ?.toLowerCase()
                    .contains(argument?.filterBy.toLowerCase() ?? "") ??
                false))
        .toList();
    setState(() {});
  }

  @override
  void dispose() {
    streamSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var argument = args(context) as DeviceCallLogs?;

    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: (widget.showAppBar ?? argument?.showAppBar ?? false)
          ? CustomAppBar(
              title: appLocalization(context).callLogs,
            )
          : null,
      body: BlocConsumer(
          bloc: callLogsListBloc,
          listener: (context, state) {
            if (state is GetDeviceCallLogState) {
              var deviceCallLogs = state.value;
              callLogsListBloc.add(SyncCallLogEvent(callLogs: deviceCallLogs));
            }
            if (state is GetCallLogsState) {
              if (state.value.statusCode == 200) {
                callLogs = state.value.callloglist ?? [];
                // filteredCallLogs = callLogs;
                filter();
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message ?? "");
              } else {
                showToast(state.value.message ?? "");
              }
            }
            if (state is SyncCallLogState) {
              if (state.value.statusCode == 200) {
                showToast(state.value.message);
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message ?? "");
              } else {
                showToast(state.value.message);
              }
              callLogsListBloc.add(GetCallLogsEvent());
            }
            if (state is DeleteAllCallLogState) {
              if (state.value.statusCode == 200) {
                showCustomDialog(context,
                    dialogType: DialogType.success,
                    subTitle: state.value.message ?? "");
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message ?? "");
              } else {
                showToast(state.value.message);
              }
              callLogsListBloc.add(GetCallLogsEvent());
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
                inAsyncCall: state is ApiLoadingState,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: searchController,
                        prefix: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        hintText: "Search numbers, names & more",
                        onChanged: (p0) {
                          filter();
                        },
                      ),
                      Expanded(
                        child: filteredCallLogs.isEmpty
                            ? const Center(
                                child: Text("No data"),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.contactDetail);
                                },
                                child: ListView.builder(
                                    itemCount: filteredCallLogs.length,
                                    itemBuilder: (context, index) =>
                                        CallLogListItem(
                                            callLog: filteredCallLogs[index])),
                              ),
                      ),
                    ],
                  ),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.callColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          IconConstants.icUsername,
          color: AppColor.secondryColor,
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 6 / 100,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.contactList);
        },
      ),
    );
  }
}

class CallLogListItem extends StatelessWidget {
  final CallLogData callLog;

  const CallLogListItem({
    super.key,
    required this.callLog,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.contactDetail,
            arguments: ContactDetail(
              contact: ContactData(
                  countryCode: callLog.countryCode,
                  mobileNo: callLog.mobileNo,
                  name: callLog.name,
                  numberType: callLog.callType,
                  id: callLog.id,
                  email: callLog.simdisplayname),
            ));
      },
      leading: Icon(getCallTypeIcon(callLog.callType),
          color: getCallTypeColor(callLog.callType)),
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
          Text(callLog.callDuration?.convertInMinSec() ?? ""),
          2.width(),
          const Circle(),
          2.width(),
          Text(
            callLog.callType ?? "",
            style: textTheme(context)
                .bodyMedium
                ?.copyWith(color: getCallTypeColor(callLog.callType)),
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
