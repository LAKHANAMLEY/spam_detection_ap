import 'package:spam_delection_app/lib.dart';

class DeviceCallLogs extends StatefulWidget {
  final bool? showAppBar;
  const DeviceCallLogs({super.key, this.showAppBar = true});

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
    // streamSubs = callLogsListBloc.stream.listen((state) {
    //   if (state is GetDeviceCallLogState) {
    //     var deviceCallLogs = state.value;
    //     if (deviceCallLogs != null) {
    //       callLogsListBloc.add(SyncCallLogEvent(callLogs: deviceCallLogs));
    //     } else {
    //       callLogsListBloc.add(GetCallLogsEvent());
    //     }
    //   }
    // });
    callLogsListBloc.add(GetDeviceCallLogEvent());
  }

  filter() {
    filteredCallLogs = callLogs
        .where((e) =>
            (e.name
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
                false) ||
            (e.mobileNo
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
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
          ? const CustomAppBar(
              title: "Call logs",
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
                filteredCallLogs = callLogs;
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
                          color: Colors.grey,
                        ),
                        hintText: "Search here",
                        onChanged: (p0) {
                          filter();
                        },
                      ),
                      Expanded(
                        child: filteredCallLogs.isEmpty
                            ? const Center(
                                child: Text("No data"),
                              )
                            : ListView.builder(
                                itemCount: filteredCallLogs.length,
                                itemBuilder: (context, index) =>
                                    CallLogListItem(
                                        callLog: filteredCallLogs[index])),
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
      leading: Icon(getIcon(callLog.callType)),
      title: Text(callLog.name ?? ""),
      subtitle: Text(callLog.mobileNo ?? ""),
      trailing: Text(callLog.callTime?.formatDateTime() ?? ""),
    );
  }
}

IconData getIcon(String? callLogType) {
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
