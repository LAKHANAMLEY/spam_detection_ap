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
    callLogDetailBloc.add(GetDeviceCallLogEvent());
  }

  void onError(error) {}

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
        child: BlocBuilder(
            bloc: callLogDetailBloc,
            builder: (context, state) {
              if (state is GetDeviceCallLogState) {
                var callLog = state.value.first;
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
                                    "${callLog.callType?.name ?? ""} call",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color: getCallTypeColor(
                                                callLog.callType?.name)),
                                  ),
                                  5.width(),
                                  Text(
                                    callLog.simDisplayName ?? "",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                  5.width(),
                                  Text(
                                    callLog.timestamp
                                            ?.toDateTime()
                                            .formatDateTime() ??
                                        "",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                callLog.name ?? callLog.number ?? "",
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
                                  name: callLog.name,
                                  mobileNo: callLog.number ?? "",
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
                          Text(callLog.number ?? ""),
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
