import 'package:spam_delection_app/lib.dart';
import 'package:system_alert_window/system_alert_window.dart';

class OutSideAppOverlay extends StatefulWidget {
  const OutSideAppOverlay({super.key});

  @override
  State<OutSideAppOverlay> createState() => _OutSideAppOverlayState();
}

class _OutSideAppOverlayState extends State<OutSideAppOverlay> {
  var callLogDetailBloc = ApiBloc(ApiBlocInitialState());

  StreamSubscription? streamSubs;

  void onData(data) {
    var callLog = CallLogData.fromJson(data);
    callLogDetailBloc.add(GetDeviceCallLogEvent(
      number: callLog.mobileNo,
      dateTimeFrom: DateTime.now().subtract(const Duration(days: 1)),
      dateTimeTo: DateTime.now(),
    ));
    // callLogDetailBloc.add(SyncCallLogManuallyEvent(
    //     callLogs: CallLogEntry(
    //   number: callLog.mobileNo,
    //   callType: getCallLogType(callLog.callType),
    //   duration: int.parse(callLog.callDuration ?? "0"),
    // )));
  }

  void onError(error) {
    showToast(error);
  }

  @override
  void initState() {
    super.initState();
    streamSubs =
        SystemAlertWindow.overlayListener.listen(onData, onError: onError);
  }

  @override
  void dispose() {
    streamSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: BlocConsumer(
            bloc: callLogDetailBloc,
            listener: (context, state) {
              if (state is GetDeviceCallLogState) {
                if (state.value.isNotEmpty) {
                  var deviceCallLogs = state.value.first;
                  callLogDetailBloc
                      .add(SyncCallLogManuallyEvent(callLogs: deviceCallLogs));
                }
              }
              if (state is SyncCallManuallyState) {
                if (state.value.statusCode == 200) {
                  // var deviceCallLogs = state.value;
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message);
                } else {
                  showToast(state.value.message);
                }
              }
            },
            builder: (context, state) {
              if (state is SyncCallManuallyState) {
                var callLog = state.value.callLog;
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    // color: AppColor.callColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(IconConstants.icCaller),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Image.asset(IconConstants.icBroadlogo),
                          // ),
                          5.width(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${callLog?.callType ?? ""} call",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color: getCallTypeColor(
                                                callLog?.callType)),
                                  ),
                                  5.width(),
                                  Text(
                                    callLog?.simdisplayname ?? "",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                  5.width(),
                                  Text(
                                    callLog?.callTime?.formatDateTime() ?? "",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                callLog?.name ?? callLog?.mobileNo ?? "",
                                style: textTheme(context).titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      20.height(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          // fixedSize: Size(double.infinity, 30),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.contactDetail,
                              arguments: ContactDetail(
                                contact: ContactData(
                                  name: callLog?.name,
                                  mobileNo: callLog?.mobileNo ?? "",
                                ),
                              ));
                        },
                        label: const Text("View profile"),
                        icon: const Icon(Icons.account_circle),
                      ),
                      20.height(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(callLog?.mobileNo ?? ""),
                          // Text(callLog.cachedNumberLabel ?? ""),
                        ],
                      ),
                      10.height(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [Icon(Icons.phone), Text("CALL")],
                          ),
                          Column(
                            children: [Icon(Icons.message), Text("MESSAGE")],
                          ),
                          Column(
                            children: [Icon(Icons.voice_chat), Text("VOICE")],
                          ),
                          Column(
                            children: [Icon(Icons.edit), Text("EDIT")],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return const Loader();
            }));
  }
}
