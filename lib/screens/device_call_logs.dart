import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/extensions/date_time_ext.dart';
import 'package:spam_delection_app/extensions/timestamp_ext.dart';
import 'package:spam_delection_app/screens/widgets/custom_app_bar.dart';
import 'package:spam_delection_app/screens/widgets/custom_textfiled.dart';

class DeviceCallLogs extends StatefulWidget {
  const DeviceCallLogs({super.key});

  @override
  State<DeviceCallLogs> createState() => _DeviceCallLogsState();
}

class _DeviceCallLogsState extends State<DeviceCallLogs> {
  List<CallLogEntry> callLogs = [];
  List<CallLogEntry> filteredCallLogs = [];

  var searchController = TextEditingController();

  var getDeviceCallLogBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    getDeviceCallLogBloc.add(GetDeviceCallLogEvent());
  }

  filter() {
    filteredCallLogs = callLogs
        .where((e) =>
            (e.name
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
                false) ||
            (e.number
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
                false))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Call logs",
      ),
      body: BlocConsumer(
          bloc: getDeviceCallLogBloc,
          listener: (context, state) {
            if (state is GetDeviceCallLogState) {
              callLogs = state.value;
              filteredCallLogs = callLogs;
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
    );
  }
}

class CallLogListItem extends StatelessWidget {
  final CallLogEntry callLog;

  const CallLogListItem({
    super.key,
    required this.callLog,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(getIcon(callLog.callType)),
      title: Text(callLog.name ?? ""),
      subtitle: Text(callLog.number ?? ""),
      trailing: Text(callLog.timestamp?.toDate().formatDateTime() ?? ""),
    );
  }
}

IconData getIcon(CallType? callType) {
  switch (callType) {
    case null:
      return Icons.call_received;
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
  }
}
