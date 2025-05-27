import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:system_alert_window/system_alert_window.dart';

class OutSideAppOverlay extends StatefulWidget {
  const OutSideAppOverlay({super.key});

  @override
  State<OutSideAppOverlay> createState() => _OutSideAppOverlayState();
}

class _OutSideAppOverlayState extends State<OutSideAppOverlay> {
  // var callLogDetailBloc = ApiBloc(ApiBlocInitialState());

  StreamSubscription? streamSubs;

  CallLogData? contactData;

  CallLogData? callLog;

  void onData(data) {
    callLog = CallLogData.fromJson(data);
    context.read<CallLogDBBloc>().add(GetDBCallLog(
        mobileNo: callLog?.mobileNo?.separatePhoneAndPhoneCode().phone ?? ""));
    // callLogDetailBloc.add(GetDeviceCallLogEvent(
    //   number: callLog.mobileNo,
    //   // dateTimeFrom: DateTime.now().subtract(const Duration(days: 1)),
    //   // dateTimeTo: DateTime.now(),
    // ));
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
    Color textColor = AppColor.whiteColor;
    return Material(
        child: BlocConsumer<CallLogDBBloc, CallLogDBState>(
      listener: (context, state) {
        if (state is CallLogDBLoadedById) {
          contactData = state.callLog.copyWith(
            callType: callLog?.callType,
            callDuration: callLog?.callDuration,
          );
        }
      },
      // bloc: callLogDetailBloc,
      // listener: (context, state) {
      //   if (state is GetDeviceCallLogState) {
      //     if (state.value.isNotEmpty) {
      //       var deviceCallLogs = state.value.first;

      //       var callLog = CallLogData(
      //         isManually: "1",
      //         mobileNo:
      //             deviceCallLogs.number?.separatePhoneAndPhoneCode().phone,
      //         countryCode:
      //             deviceCallLogs.number?.separatePhoneAndPhoneCode().phoneCode,
      //         name: deviceCallLogs.name,
      //         callDuration: deviceCallLogs.duration.toString(),
      //         callDurations: deviceCallLogs.duration.toString(),
      //         callDurationUnit: "1",
      //         callTime: deviceCallLogs.timestamp?.toDateTime(),
      //         callType: deviceCallLogs.callType?.name,
      //         simdisplayname: deviceCallLogs.simDisplayName,
      //         phoneaccountid: deviceCallLogs.phoneAccountId,
      //         contactListId: "0",
      //       );
      //       contactData = ContactData(
      //         // isManually: "1",
      //         mobileNo:
      //             deviceCallLogs.number?.separatePhoneAndPhoneCode().phone,
      //         countryCode:
      //             deviceCallLogs.number?.separatePhoneAndPhoneCode().phoneCode,
      //         name: deviceCallLogs.name,
      //         callHistory: [callLog],
      //         isSpam: 0,
      //         isBlocked: 0,
      //         // callDurations: deviceCallLogs.duration.toString(),
      //         // callDurationUnit: "1",
      //         // callTime: deviceCallLogs.timestamp?.toDateTime(),
      //         // callType: deviceCallLogs.callType?.name,
      //         // simdisplayname: deviceCallLogs.simDisplayName,
      //         // phoneaccountid: deviceCallLogs.phoneAccountId,
      //         // contactListId: "0",
      //       );
      //       callLogDetailBloc.add(CheckSpamEvent(
      //         callLogs: callLog,
      //       ));
      //     }
      //   }
      //   if (state is CheckSpamState) {
      //     if (state.value.statusCode == 200) {
      //       contactData = state.value.phonespamdetails;
      //       // var deviceCallLogs = state.value;
      //     } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
      //       sessionExpired(context, state.value.message);
      //     } else {
      //       showToast(state.value.message);
      //     }
      //   }
      // },
      builder: (context, state) {
        if (state is CallLogDBError) {
          return Center(
            child: Text(state.message),
          );
        }
        // if (state is CheckSpamState) {
        return Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: contactData?.isSpam == 1
                ? AppColor.redColor
                : AppColor.themeOrangeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (contactData != null)
                    CircleAvatar(
                      // child: Image.asset(getCallTypeImage(contactData!)),
                      child: SvgPicture.asset(
                        CallTypeHelper.getSvgImageByCallType(contactData!),
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                        placeholderBuilder: (context) => Loader(),
                      ),
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
                            "${contactData?.callType ?? ""} call",
                            style: textTheme(context).bodySmall?.copyWith(
                                  color: AppColor.whiteColor,
                                  // color: getCallTypeColor(callLog
                                  //     ?.callHistory
                                  //     ?.first
                                  //     .callType),
                                ),
                          ),
                          5.width(),
                          Text(
                            contactData?.simdisplayname ?? "",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                          5.width(),
                          Text(
                            contactData?.callTime?.formatRelativeDateTime() ??
                                "",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        (contactData?.name?.isNotEmpty ?? false)
                            ? contactData?.name ?? ""
                            : ((contactData?.countryCode?.isNotEmpty ?? false)
                                ? ("+${contactData?.countryCode ?? ""} ${contactData?.mobileNo ?? ""}")
                                : contactData?.mobileNo ?? ""),
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
                          name: contactData?.name,
                          mobileNo: contactData?.mobileNo ?? "",
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
                    (contactData?.countryCode?.isNotEmpty ?? false)
                        ? "+${contactData?.countryCode ?? ""} ${contactData?.mobileNo ?? ""}"
                        : contactData?.mobileNo ?? "",
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
                          contactData?.mobileNo ?? "");
                    },
                  ),
                  Btn(
                    icon: Icons.message,
                    text: "MESSAGE",
                    onTap: () {
                      launchSms(context, contactData?.mobileNo ?? "");
                    },
                  ),
                  const Btn(icon: Icons.voice_chat, text: "VOICE"),
                  const Btn(icon: Icons.edit, text: "EDIT"),
                ],
              )
            ],
          ),
        );
        // }
        // return const Loader();
      },
    ));
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
