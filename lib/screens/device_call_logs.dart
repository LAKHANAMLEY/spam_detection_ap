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

  var scrollController = ScrollController();

  bool isVisible = false;

  var showHideTextFieldBloc = SelectionBloc(SelectBoolState(true));

  @override
  void initState() {
    super.initState();
    // callLogsListBloc.add(GetDeviceCallLogEvent());
    ///TODO: sync only on splash and manually sync btn pressed
    callLogsListBloc.add(GetCallLogsEvent());
    // scrollController.addListener(() {
    // var isTrue = scrollController.position.userScrollDirection ==
    //     ScrollDirection.reverse;
    // showHideTextFieldBloc.add(SelectBoolEvent(!isTrue));
    // setState(() {});
    // });
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
    // scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var argument = args(context) as DeviceCallLogs?;

    return Scaffold(
      // backgroundColor: AppColor.whiteLight,
      appBar: (widget.showAppBar ?? argument?.showAppBar ?? false)
          ? CustomAppBar(
              title: appLocalization(context).callLogs,
            )
          : null,
      body: BlocConsumer(
          bloc: markSpamBloc,
          listener: (context, state) {
            if (state is MarkSpamState) {
              if (state.value.statusCode == 200) {
                showCustomDialog(
                  context,
                  dialogType: DialogType.success,
                  subTitle: state.value.message,
                );
                callLogsListBloc.add(GetCallLogsEvent());
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message ?? "");
              } else {
                showCustomDialog(
                  context,
                  dialogType: DialogType.failed,
                  subTitle: state.value.message,
                );
              }
            }
            if (state is RemoveSpamState) {
              if (state.value.statusCode == 200) {
                showCustomDialog(context,
                    dialogType: DialogType.success,
                    subTitle: state.value.message);
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message);
              } else {
                showCustomDialog(context,
                    dialogType: DialogType.failed,
                    subTitle: state.value.message);
              }
              callLogsListBloc.add(GetCallLogsEvent());
              // markSpamBloc.add(GetSpamEvent());
            }
            if (state is BlockUnBlockState) {
              if (state.value.statusCode == 200) {
                showCustomDialog(context,
                    dialogType: DialogType.success,
                    subTitle: state.value.message);
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message);
              } else {
                showCustomDialog(context,
                    dialogType: DialogType.failed,
                    subTitle: state.value.message.toString());
              }
              callLogsListBloc.add(GetCallLogsEvent());
              // markSpamBloc.add(GetSpamEvent());
            }
          },
          builder: (context, markSpamState) {
            return BlocConsumer(
                bloc: callLogsListBloc,
                listener: (context, state) {
                  if (state is GetDeviceCallLogState) {
                    var deviceCallLogs = state.value;
                    callLogsListBloc
                        .add(SyncCallLogEvent(callLogs: deviceCallLogs));
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
                      inAsyncCall: state is ApiLoadingState ||
                          markSpamState is ApiLoadingState,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            BlocBuilder(
                                bloc: showHideTextFieldBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return AnimatedScale(
                                      onEnd: () {
                                        isVisible = state.value;
                                      },
                                      scale: state.value ? 1 : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: !isVisible
                                          ? CustomTextField(
                                              controller: searchController,
                                              fillColor: Colors.white,
                                              prefix: const Icon(
                                                Icons.search,
                                                color: Colors.red,
                                              ),
                                              hintText:
                                                  "Search numbers, names & more",
                                              onChanged: (p0) {
                                                filter();
                                              },
                                              suffix: PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        callLogsListBloc.add(
                                                            GetDeviceCallLogEvent());
                                                      },
                                                      child: const Text(
                                                          "Sync call logs"))
                                                ],
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    );
                                  }
                                  return const Loader();
                                }),
                            Expanded(
                              child: filteredCallLogs.isEmpty
                                  ? const Center(
                                      child: Text("No data"),
                                    )
                                  : ListView.builder(
                                      controller: scrollController,
                                      itemCount: filteredCallLogs.length,
                                      itemBuilder: (context, index) =>
                                          CallLogListItem(
                                            callLog: filteredCallLogs[index],
                                          )),
                            ),
                          ],
                        ),
                      ));
                });
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
        onPressed: () async {
          // await SystemAlertWindow.showSystemWindow();
          // await SystemAlertWindow.checkPermissions();
          // await SystemAlertWindow.requestPermissions();
          // await SystemAlertWindow.sendMessageToOverlay("hello");
          // await SystemAlertWindow.updateSystemWindow();
          Navigator.pushNamed(context, AppRoutes.contactList);
        },
      ),
    );
  }
}
