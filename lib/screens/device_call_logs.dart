import 'package:spam_delection_app/lib.dart';

class DeviceCallLogs extends StatelessWidget {
  final bool? showAppBar;
  final String filterBy;

  const DeviceCallLogs({super.key, this.showAppBar = true, this.filterBy = ""});

  @override
  Widget build(BuildContext context) {
    // List<CallLogData> callLogs = [];
    // List<CallLogData> filteredCallLogs = [];
    final searchController = TextEditingController();
    final scrollController = ScrollController();
    bool isVisible = false;
    final showHideTextFieldBloc = SelectionBloc(SelectBoolState(true));
    final searchBloc = SelectionBloc(SelectStringState(""));
    // callLogsListBloc.add(GetCallLogsEvent());
    return Scaffold(
      appBar: (showAppBar ?? showAppBar ?? false)
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
                  if (state is ApiBlocInitialState) {
                    callLogsListBloc.add(GetCallLogsEvent());
                  }
                  if (state is GetDeviceCallLogState) {
                    var deviceCallLogs = state.value;
                    callLogsListBloc
                        .add(SyncCallLogEvent(callLogs: deviceCallLogs));
                  }
                  if (state is GetCallLogsState) {
                    if (state.value.statusCode == 200) {
                      // callLogs = state.value.callloglist ?? [];
                      // filteredCallLogs = filter("", callLogs);
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
                  if (state is DeleteCallLogState) {
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
                builder: (context, state) {
                  if (state is GetCallLogsState) {
                    var callLogs = state.value.callloglist ?? [];
                    var filteredCallLogs = filter("", callLogs);
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
                                                fillColor:
                                                    AppColor.secondryColor,
                                                prefix: const Icon(
                                                  Icons.search,
                                                  color: AppColor.redColor,
                                                ),
                                                hintText:
                                                    appLocalization(context)
                                                        .searchMore,
                                                //textAlign: TextAlign.center,

                                                onChanged: (p0) {
                                                  // filter();
                                                  searchBloc.add(
                                                      SelectStringEvent(p0));
                                                },
                                                suffix: PopupMenuButton(
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          callLogsListBloc.add(
                                                              GetDeviceCallLogEvent());
                                                        },
                                                        child: Text(
                                                            appLocalization(
                                                                    context)
                                                                .synCallLogs)),
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          callLogsListBloc.add(
                                                              DeleteAllCallLogEvent());
                                                        },
                                                        child: Text(appLocalization(
                                                                context)
                                                            .deleteAllCallLogs)),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      );
                                    }
                                    return const Loader();
                                  }),
                              BlocConsumer(
                                  bloc: searchBloc,
                                  listener: (context, state) {
                                    if (state is SelectStringState) {
                                      filteredCallLogs =
                                          filter(state.value ?? "", callLogs);
                                    }
                                  },
                                  builder: (context, state) {
                                    return (filteredCallLogs.isEmpty &&
                                            searchController.text.isNotEmpty)
                                        ? CallLogListItem(
                                            // showPopupMenuBtn: false,
                                            callLog: CallLogData(
                                            mobileNo: searchController.text,
                                          ))
                                        // Center(
                                        //     child: Text(appLocalization(context)
                                        //         .noData),
                                        //   )
                                        : Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                controller: scrollController,
                                                itemCount:
                                                    filteredCallLogs.length,
                                                itemBuilder: (context, index) =>
                                                    CallLogListItem(
                                                      callLog: filteredCallLogs[
                                                          index],
                                                    )),
                                          );
                                  }),
                            ],
                          ),
                        ));
                  }
                  return const Loader();
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.callColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          IconConstants.icUserData,
          scale: 2,
          color: AppColor.secondryColor,
        ),
        onPressed: () async {
          Navigator.pushNamed(context, AppRoutes.contactList);
        },
      ),
    );
  }

  List<CallLogData> filter(String searchText, List<CallLogData> callLogs) {
    return callLogs
        .where((e) =>
            ((e.name?.toLowerCase().contains(searchText.toLowerCase()) ??
                    false) ||
                (e.mobileNo?.toLowerCase().contains(searchText.toLowerCase()) ??
                    false)) &&
            (e.callType?.toLowerCase().contains(filterBy.toLowerCase() ?? "") ??
                false))
        .toList();
    // setState(() {});
  }
}
