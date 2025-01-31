import 'package:direct_call_plus/direct_call_plus.dart';
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
      // dateTimeFrom: DateTime.now().subtract(const Duration(days: 1)),
      // dateTimeTo: DateTime.now(),
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
    Color textColor = AppColor.secondaryColor;
    return Material(
        child: BlocConsumer(
            bloc: callLogDetailBloc,
            listener: (context, state) {
              if (state is GetDeviceCallLogState) {
                if (state.value.isNotEmpty) {
                  var deviceCallLogs = state.value.first;
                  callLogDetailBloc.add(CheckSpamEvent(
                      callLogs: CallLogData(
                    isManually: "1",
                    mobileNo: deviceCallLogs.number
                        ?.separatePhoneAndPhoneCode()
                        .phone,
                    countryCode: deviceCallLogs.number
                        ?.separatePhoneAndPhoneCode()
                        .phoneCode,
                    name: deviceCallLogs.name,
                    callDuration: deviceCallLogs.duration.toString(),
                    callDurations: deviceCallLogs.duration.toString(),
                    callDurationUnit: "1",
                    callTime: deviceCallLogs.timestamp?.toDateTime(),
                    callType: deviceCallLogs.callType?.name,
                    simdisplayname: deviceCallLogs.simDisplayName,
                    phoneaccountid: deviceCallLogs.phoneAccountId,
                    contactListId: "0",
                  )));
                }
              }
              if (state is CheckSpamState) {
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
              if (state is CheckSpamState) {
                var callLog = state.value.phonespamdetails;
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: callLog?.isSpam == 1
                        ? AppColor.redColor
                        : AppColor.callColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset(
                                getCallTypeImage(callLog!.callHistory!.first)),
                            // backgroundImage: AssetImage(callLog?.isSpam == 1
                            //     ? IconConstants.icspamCircle
                            //     : IconConstants.icCaller),
                          ),
                          5.width(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${callLog.callHistory?.first.callType ?? ""} call",
                                    style:
                                        textTheme(context).bodySmall?.copyWith(
                                              color: AppColor.secondaryColor,
                                              // color: getCallTypeColor(callLog
                                              //     ?.callHistory
                                              //     ?.first
                                              //     .callType),
                                            ),
                                  ),
                                  5.width(),
                                  Text(
                                    callLog.callHistory?.first.simdisplayname ??
                                        "",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  5.width(),
                                  Text(
                                    callLog.callHistory?.first.callTime
                                            ?.formatRelativeDateTime() ??
                                        "",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                callLog.name ??
                                    ((callLog.countryCode?.isNotEmpty ?? false)
                                        ? ("+${callLog.countryCode ?? ""} ${callLog.mobileNo ?? ""}")
                                        : callLog.mobileNo ?? ""),
                                style: textTheme(context)
                                    .titleMedium
                                    ?.copyWith(color: textColor),
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
                                  mobileNo: callLog.mobileNo ?? "",
                                ),
                              ));
                        },
                        label: Text(appLocalization(context).viewProfile),
                        icon: const Icon(Icons.account_circle),
                      ),
                      20.height(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "+${callLog.countryCode ?? ""} ${callLog.mobileNo ?? ""}",
                            style: textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: textColor),
                          ),
                          // Text(callLog.cachedNumberLabel ?? ""),
                        ],
                      ),
                      10.height(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Btn(
                            icon: Icons.phone,
                            text: "CALL",
                            onTap: () async {
                              await DirectCallPlus.makeCall(
                                  callLog.mobileNo ?? "");
                            },
                          ),
                          Btn(
                            icon: Icons.message,
                            text: "MESSAGE",
                            onTap: () {
                              launchSms(context, callLog.mobileNo ?? "");
                            },
                          ),
                          const Btn(icon: Icons.voice_chat, text: "VOICE"),
                          const Btn(icon: Icons.edit, text: "EDIT"),
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

class Btn extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const Btn({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          Text(
            text,
            style: textTheme(context).bodyMedium?.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
